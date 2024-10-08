% ---------------- %
%
% SDP_MAO_CAO
%
% ---------------- %



ZERO = 1e-6; % ZERO-Tolerance of strict LMIs

xk = sdpvar(nx,1);
X = sdpvar(nx);
Y = sdpvar(nu,nx);
Z = sdpvar(nu,nx);
g = sdpvar(1);
U = sdpvar(nu,nu);
for v = 1 : nv
    Q{v,1} = sdpvar(nx);
end % for v

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
obj = g + trace(X);

% Constr
%
constr = [];

% Lyapunov Matrix
%
lmi_lyap = [g >= 0];
for v = 1 : nv
    lmi_lyap_item = [Q{v} >= ZERO];
    lmi_lyap = lmi_lyap + lmi_lyap_item;
end % for v

% Robust Invariant Ellipsoid
%
lmi_rie = [];
for v = 1 : nv
    lmi_rie_item = [ [1, xk'; xk, Q{v}] >= ZERO ];
    lmi_rie = lmi_rie + lmi_rie_item;
end % for v

% Convergency
%
lmi_conv = [];
for v = 1 : nv
for vp = 1 : nv
for j = 1 : nj

lmi_conv_item = [ [X + X' - Q{v}, (A{v}*X + B{v}*(E{j}*Y + Et{j}*Z))', (sqrt(Wx)*X)', (sqrt(Wu)*(E{j}*Y + Et{j}*Z))';...
    (A{v}*X + B{v}*(E{j}*Y + Et{j}*Z)), Q{vp}, ZEROx, ZEROxu;...
    sqrt(Wx)*X, ZEROx, g*Ix, ZEROxu;...
    sqrt(Wu)*(E{j}*Y + Et{j}*Z), ZEROux, ZEROux, g*Iu] >= ZERO ];
lmi_conv = lmi_conv + lmi_conv_item;

end % for j
end % for vp
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
    for v = 1 : nv

    lmi_u_max_item = [ [ diag(u_max.^2), Z;...
        Z', X + X' - Q{v}] >= ZERO ];
    lmi_u_max = lmi_u_max + lmi_u_max_item;

    end % for v
    %
    % L1-norm
    %
    for v = 1 : nv

    lmi_u_max_item = [ [ U, Z;...
        Z', X + X' - Q{v}] >= ZERO ];
    lmi_u_max = lmi_u_max + lmi_u_max_item;

    end % for v
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
    for v = 1 : nv
	for j = 1 : nj

    lmi_x_max_item = [ [diag(x_max.^2), C{v}*(A{v}*X + B{v}*(E{j}*Y + Et{j}*Z));...
        (A{v}*X + B{v}*(E{j}*Y + Et{j}*Z))'*C{v}', X + X' - Q{v} ] >= ZERO ];

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
    Ut = [U, zeros(row(2),max(col)-nu)];
    M  = [M; Ut];
end % if

% Handle the PDLF-matrices X in Case Feasibility-Check is Required
%
if(isequal(setup.chk_feas,'on'))
    %
    % Add NV-times (NX x NX)-dimmensional matrix X{v}
    %
    for v = 1 : nv

    row = [row, nx];
	col = [col, nx];
    Qt  = [Q{v}, zeros(nx,max(col)-nx)];
    M   = [M; Qt];

    end % for v
    
end % if
%
out = sdpvar(sum(row),max(col));

% Constraints
%
constr = lmi_lyap + lmi_rie + lmi_conv + lmi_u_max + lmi_x_max;

% Optimizer Constraints
%
constr_optimizer = constr + [out == M];
