% ---------------- %
%
% SDP_KOTHARE
%
% ---------------- %



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
lmi_lyap = [g >= 0, X >= ZERO];

% Robust Invariant Ellipsoid
%
lmi_rie = [ [1, xk'; xk, X] >= ZERO ];

% Convergency
%
lmi_conv = [];
%
for v = 1 : nv

lmi_conv_item = [ [X, (A{v}*X + B{v}*Y )', (sqrt(Wx)*X)', (sqrt(Wu)*Y)';...
    A{v}*X + B{v}*Y, X, ZEROx, ZEROxu;...
    sqrt(Wx)*X, ZEROx, g*Ix, ZEROxu;...
    sqrt(Wu)*Y, ZEROux, ZEROux, g*Iu] >= ZERO ];

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
    for v = 1 : nv

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
