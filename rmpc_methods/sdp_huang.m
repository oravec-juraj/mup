% ---------------- %
%
% SDP_HUANG
%
% ---------------- %


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

if(isempty(beta) == 1)
    error(' MUP:BLOCK:RMPC: HUANG ET AL. (2011): Parameter BETA was not defined!')
end

% Objective
%
obj = g + beta*gs + trace(X);

% Constr
%
constr = [];

% Auxiliary Weighted Bound
%
gs_bound = [g >= 0, gs >= 0, g - gs >= ZERO];

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
for v = 1 : nv

lmi_conv_item = [ [X, (A{v}*X + B{v}*Y)', (sqrt(Wx)*X)', (sqrt(Wu)*Y)';...
    A{v}*X + B{v}*Y, X, ZEROx, ZEROxu;...
    sqrt(Wx)*X, ZEROx, gs*Ix, ZEROxu;...
    sqrt(Wu)*Y, ZEROux, ZEROux, gs*Iu] >= ZERO ];

lmi_conv = lmi_conv + lmi_conv_item;

end % for v
%
for v = 1 : nv
for j = 2 : nj

lmi_conv_item = [ [X, (A{v}*X + B{v}*(E{j}*Y + Et{j}*Z) )', (sqrt(Wx)*X)', (sqrt(Wu)*(E{j}*Y + Et{j}*Z))';...
    A{v}*X + B{v}*(E{j}*Y + Et{j}*Z), X, ZEROx, ZEROxu;...
    sqrt(Wx)*X, ZEROx, g*Ix, ZEROxu;...
    sqrt(Wu)*(E{j}*Y + Et{j}*Z), ZEROux, ZEROux, g*Iu] >= ZERO ];

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
