% ---------------- %
%
% SDP_WAN_HUANG
%
% ---------------- %

% Copyright is with the following author(s):
%
% (c) 2016 Juraj Oravec, Slovak University of Technology in Bratislava,
% juraj.oravec@stuba.sk
% (c) 2016 Monika Bakosova, Slovak University of Technology in Bratislava,
% monika.bakosova@stuba.sk
% ------------------------------------------------------------------------------
% Legal note:
% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public
% License as published by the Free Software Foundation; either
% version 2.1 of the License, or (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
% General Public License for more details.
%
% You should have received a copy of the GNU General Public
% License along with this library; if not, write to the
% Free Software Foundation, Inc.,
% 59 Temple Place, Suite 330,
% Boston, MA 02111-1307 USA
%
% ------------------------------------------------------------------------------

% Additional RMPC-Tunning Parameter

ZERO = 1e-6; % ZERO-Tolerance of strict LMIs

xk = sdpvar(nx,1);
X = sdpvar(nx);
Y = sdpvar(nu,nx);
Z = sdpvar(nu,nx);
g = sdpvar(1);
gs = sdpvar(1);
U = sdpvar(nu,nu);

ZEROx = zeros(nx,nx);
ZEROux = zeros(nu,nx);
ZEROxu = zeros(nx,nu);
Ix = eye(nx);
Iu = eye(nu);

[u_var,nj] = get_variat(nu);
for j = 1 : nj
    E{j,1} = diag(u_var(:,nj + 1 - j));
    Et{j,1} = diag(u_var(:,j));
end % for j

% Objective
%
obj = g + beta*gs + trace(X);

% Constr
%
constr = [];

% Auxiliary Weighted Bound
%
gs_bound = [g - gs >= ZERO];

% Lyapunov Matrix
%
lmi_lyap = [X >= ZERO];

% Robust Invariant Ellipsoid
%
lmi_rie = [ [1, xk'; xk, X] >= ZERO ];

% Convergency
%
lmi_conv = [];
%
% Nominal System
%
% Nominal System Unconstrained - To Be Saturated
lmi_conv = [ [X, (A{end}*X + B{end}*Y )', (sqrt(Wx)*X)', (sqrt(Wu)*Y)';...
    A{end}*X + B{end}*Y, X, ZEROx, ZEROxu;...
    sqrt(Wx)*X, ZEROx, gs*Ix, ZEROxu;...
    sqrt(Wu)*Y, ZEROux, ZEROux, gs*Iu] >= ZERO ];
%
% Nominal System Constrained - To Have The Guarantee of Robust Stability
for j = 2 : nj

lmi_conv_item = [ [X, (A{end}*X + B{end}*(E{j}*Y + Et{j}*Z) )', (sqrt(Wx)*X)', (sqrt(Wu)*(E{j}*Y + Et{j}*Z))';...
    A{end}*X + B{end}*(E{j}*Y + Et{j}*Z), X, ZEROx, ZEROxu;...
    sqrt(Wx)*X, ZEROx, g*Ix, ZEROxu;...
    sqrt(Wu)*(E{j}*Y + Et{j}*Z), ZEROux, ZEROux, g*Iu] >= ZERO ];

lmi_conv = lmi_conv + lmi_conv_item;

end % for j
%
% Uncertain Vertrices
%
for v = 1 : nv
for j = 1 : nj

lmi_conv_item = [ [X, (A{v}*X + B{v}*(E{j}*Y + Et{j}*Z) )';...
    A{v}*X + B{v}*(E{j}*Y + Et{j}*Z), X] >= ZERO ];

lmi_conv = lmi_conv + lmi_conv_item;

end % for j
end % for v

% Input Constraints
%
lmi_u_max = [];
%
if(isempty(u_max) == 0)
    %
    % L2-norm
    %
    lmi_u_max = [ [ diag(u_max.^2), Z;...
    Z', X] >= ZERO ];
    %
    % L1-norm
    %
    lmi_u_max = lmi_u_max + [ [ U, Z;...
        Z', X] >= ZERO ];
    for j = 1 : nu
        lmi_u_max = lmi_u_max + [ U(j,j) <= u_max(j)^2 ];
    end % for j
end % if

% Output Constraints
%
lmi_x_max = [];
%
if(isempty(x_max) == 0)
    for v = 1 : nv
    for j = 1 : nj

    lmi_x_max_item = [ [diag(x_max.^2), C{v}*(A{v}*X + B{v}*(E{j}*Y + Et{j}*Z));...
        (A{v}*X + B{v}*(E{j}*Y + Et{j}*Z))'*C{v}', X ] >= ZERO ];

    lmi_x_max = lmi_x_max + lmi_x_max_item;

    end % for j
    end % for v
end % if


% Optimizer Matrices
%
row = [nx,nu,nu,1,1];
col = [nx,nx,nx,1,1];
if(isempty(u_max) == 0) % For Input Constraints U_MAX
    row = [row,nu];
	col = [col,nu];
end % if
Xt = [X, zeros(row(1),max(col)-col(1))];
Yt = [Y, zeros(row(2),max(col)-col(2))];
Zt = [Z, zeros(row(3),max(col)-col(3))];
gt = [g, zeros(row(4),max(col)-col(4))];
gst = [gs, zeros(row(5),max(col)-col(5))];
M  = [Xt; Yt; Zt; gt; gst];
if(isempty(u_max) == 0) % For Input Constraints U_MAX
    Ut = [U, zeros(row(6),max(col)-col(6))];
    M  = [M; Ut];
end % if
%
out = sdpvar(sum(row),max(col));

% Constraints
%
constr = gs_bound + lmi_lyap + lmi_rie + lmi_conv + lmi_u_max + lmi_x_max + [ g - gs >= ZERO ];

% Optimizer Constraints
%
constr_optimizer = constr + [out == M];
