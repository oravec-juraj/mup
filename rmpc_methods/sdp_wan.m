% ---------------- %
%
% SDP_WAN
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


ZERO = 1e-6; % ZERO-Tolerance of strict LMIs

xk = sdpvar(nx,1);
X = sdpvar(nx);
Y = sdpvar(nu,nx);
U = sdpvar(nu,nu);
g = sdpvar(1);

ZEROx = zeros(nx,nx);
ZEROux = zeros(nu,nx);
ZEROxu = zeros(nx,nu);
Ix = eye(nx);
Iu = eye(nu);

% Objective
%
obj = g + trace(X);

% Constr
%
constr = [];

% Lyapunov Matrix
%
lmi_lyap = [g >= ZERO, X >= ZERO];

% Robust Invariant Ellipsoid
%
lmi_rie = [ [1, xk'; xk, X] >= ZERO ];

% Convergency
%
% Nominal System
%
lmi_conv = [ [X, (A{end}*X + B{end}*Y )', (sqrt(Wx)*X)', (sqrt(Wu)*Y)';...
    A{end}*X + B{end}*Y, X, ZEROx, ZEROxu;...
    sqrt(Wx)*X, ZEROx, g*Ix, ZEROxu;...
    sqrt(Wu)*Y, ZEROux, ZEROux, g*Iu] >= ZERO ];
%
for v = 1 : nv-1

% Uncertain Vertrices
%
lmi_conv_item = [ [X, (A{v}*X + B{v}*Y )';...
    A{v}*X + B{v}*Y, X] >= ZERO ];

lmi_conv = lmi_conv + lmi_conv_item;

end % for v

% Input Constraints
%
lmi_u_max = [];
%
if(isempty(u_max) == 0)
    %
    % L2-norm
    %
    lmi_u_max = [ [ diag(u_max.^2), Y;...
        Y', X] >= ZERO ];
    %
    % L1-norm
    %
    lmi_u_max = lmi_u_max + [ [ U, Y;...
        Y', X] >= ZERO ];
    for j = 1 : nu
        lmi_u_max = lmi_u_max + [ U(j,j) <= u_max(j)^2 ];
    end % for j
end % if

% Output Constraints
%
lmi_x_max = [];
if(isempty(x_max) == 0)
    for v = 1 : nv-1

    lmi_x_max_item = [ [diag(x_max.^2), C{v}*(A{v}*X + B{v}*Y);...
        (A{v}*X + B{v}*Y)'*C{v}', X ] >= ZERO ];

    lmi_x_max = lmi_x_max + lmi_x_max_item;

    end % for v
end % if

% Optimizer Matrices
%
row = [nx,nu,1];
col = [nx,nx,1];
%
if(isempty(u_max) == 0) % For Input Constraints U_MAX
    row = [row,nu];
	col = [col,nu];
end % if
Xt = [X, zeros(row(1),max(col)-col(1))];
Yt = [Y, zeros(row(2),max(col)-col(2))];
gt = [g, zeros(row(3),max(col)-col(3))];
M  = [Xt; Yt; gt];
if(isempty(u_max) == 0) % For Input Constraints U_MAX
    Ut = [U, zeros(row(4),max(col)-col(4))];
    M  = [M; Ut];
end % if
%
out = sdpvar(sum(row),max(col));

% Constraints
%
constr = lmi_lyap + lmi_rie + lmi_conv + lmi_u_max + lmi_x_max;

% Optimizer Constraints
%
constr_optimizer = constr + [out == M];
