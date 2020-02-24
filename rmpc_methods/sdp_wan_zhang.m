% ---------------- %
%
% SDP_WAN_ZHANG
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
X = sdpvar(nx,nx,'full');
Y = sdpvar(nu,nx);
Z = sdpvar(nu,nx);
g = sdpvar(1);
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

% Saturation-Dependent Lyapunov Matrix W
for j = 1 : nj
    W{j,1} = sdpvar(nx);
end % for j

% Saturation-Dependent Lyapunov Matrix Q
for j = 1 : nj
    Q{j,1} = sdpvar(nx);
end % for j

% Objective
%
obj = g + trace(X);

% Constr
%
constr = [];

% Saturation-Dependent Lyapunov Matrix W
%
lmi_lyap = [];
for j = 1 : nj
    lmi_lyap_item = [W{j} >= ZERO];
    lmi_lyap = lmi_lyap + lmi_lyap_item;
end % for v

% Saturation-Dependent Lyapunov Matrix Q
%
lmi_lyap = [];
for j = 1 : nj
    lmi_lyap_item = [Q{j} >= ZERO];
    lmi_lyap = lmi_lyap + lmi_lyap_item;
end % for v

% Robust Invariant Ellipsoid
%
lmi_rie = [];
for j = 1 : nj
    lmi_rie_item = [ [1, xk'; xk, X + X' - W{j}] >= ZERO ];
    lmi_rie = lmi_rie + lmi_rie_item;
end % for j

% Convergency
%
lmi_conv = [];

% Nominal System
%
for j = 1 : nj
for jp = 1 : nj

lmi_conv_item = [ [X + X' - Q{jp}, (A{end}*X + B{end}*(E{j}*Y + Et{j}*Z))', (sqrt(Wx)*X)', (sqrt(Wu)*(E{j}*Y + Et{j}*Z))';...
    A{end}*X + B{end}*(E{j}*Y + Et{j}*Z), W{j}, ZEROx, ZEROxu;...
    sqrt(Wx)*X, ZEROx, g*Ix, ZEROxu;...
    sqrt(Wu)*(E{j}*Y + Et{j}*Z), ZEROux, ZEROux, g*Iu] >= ZERO ];
lmi_conv = lmi_conv + lmi_conv_item;

end % for jp
end % for j

% Vertex Systems
%
for v = 1 : nv-1
for j = 1 : nj
for jp = 1 : nj

lmi_conv_item = [ [X + X' - Q{jp}, (A{v}*X + B{v}*(E{j}*Y + Et{j}*Z) )';...
    A{v}*X + B{v}*(E{j}*Y + Et{j}*Z), W{j}] >= ZERO ];

lmi_conv = lmi_conv + lmi_conv_item;

end % for jp
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
    lmi_u_max = [];
    for j = 1 : nj

    lmi_u_max_item = [ [ diag(u_max.^2), Z;...
        Z', W{j}] >= ZERO ];
    lmi_u_max = lmi_u_max + lmi_u_max_item;

    end % for j
    %
    % L1-norm
    %
    for j = 1 : nj

    lmi_u_max_item = [ [ U, Z;...
        Z', W{j}] >= ZERO ];
    lmi_u_max = lmi_u_max + lmi_u_max_item;

    end % for j
    %
    for j = 1 : nu
        lmi_u_max = lmi_u_max + [ U(j,j) <= u_max(j)^2 ];
    end % for j
end % if

% Output Constraints
%
lmi_x_max = [];
%
if(isempty(x_max) == 0)
    for v = 1 : nv-1
    for j = 1 : nj

    lmi_x_max_item = [ [diag(x_max.^2), C{v}*(A{v}*X + B{v}*(E{j}*Y + Et{j}*Z));...
        (A{v}*X + B{v}*(E{j}*Y + Et{j}*Z))'*C{v}', X + X' - W{j} ] >= ZERO ];

    lmi_x_max = lmi_x_max + lmi_x_max_item;

    end % for j
    end % for v
end % if

% Optimizer Matrices
%
row = [nx,nu,nu,1];
col = [nx,nx,nx,1];
%
if(isempty(u_max) == 0) % For Input Constraints U_MAX
    row = [row,nu];
	col = [col,nu];
end % if
Xt = [X, zeros(row(1),max(col)-col(1))];
Yt = [Y, zeros(row(2),max(col)-col(2))];
Zt = [Z, zeros(row(3),max(col)-col(3))];
gt = [g, zeros(row(4),max(col)-col(4))];
M  = [Xt; Yt; Zt; gt];
if(isempty(u_max) == 0) % For Input Constraints U_MAX
    Ut = [U, zeros(row(5),max(col)-col(5))];
    M  = [M; Ut];
end % if
%
% Handle the SDLF-matrices W,Q in Case Feasibility-Check is Required
%
if(isequal(setup.chk_feas,'on'))
    %
    % Add NJ-times (NX x NX)-dimmensional matrix W{j}
    %
    for j = 1 : nj

    row = [row, nx];
	col = [col, nx];
    Wt = [W{j}, zeros(nx,max(col)-nx)];
    M   = [M; Wt];

    end % for j
	%
    % Add NJ-times (NX x NX)-dimmensional matrix Q{j}
    %
    for j = 1 : nj

    row = [row, nx];
	col = [col, nx];
    Qt = [Q{j}, zeros(nx,max(col)-nx)];
    M   = [M; Qt];

    end % for j
end % if
%
out = sdpvar(sum(row),max(col));

% Constraints
%
constr = lmi_lyap + lmi_rie + lmi_conv + lmi_u_max + lmi_x_max;

% Optimizer Constraints
%
constr_optimizer = constr + [out == M];
