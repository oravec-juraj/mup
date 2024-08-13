% ---------------- %
%
% SDP_SHI
%
% ---------------- %


ZERO = 1e-6; % ZERO-Tolerance of strict LMIs

% Note, value of the prediction horizon N required -> called from PARAM
if( (floor(N) ~= N ) | ( N <= 0 ) )
    error(' MUP:BLOCK:RMPC: SHI ET AL. (2013): Prediction horizon N must be a positive integer, but %f is not!',N)
end

xk = sdpvar(nx,1);
g = sdpvar(1);
U = sdpvar(nu,nu);
for t = 1 : N
    X{t,1} = sdpvar(nx);
    Y{t,1} = sdpvar(nu,nx);
    Z{t,1} = sdpvar(nu,nx);
end % for N
for t = 1 : N+1
    for v = 1 : nv
        Q{t,1}{v,1} = sdpvar(nx);
    end % for v
end % for k

[u_var,nj] = get_variat(nu);
for j = 1 : nj
    E{j,1} = diag(u_var(:,nj + 1 - j));
end % for j

ZEROx = zeros(nx,nx);
ZEROux = zeros(nu,nx);
ZEROxu = zeros(nx,nu);
Ix = eye(nx);
Iu = eye(nu);

% Objective
%
obj = g + trace(X{1});

% Constr
%
constr = [];

% Lyapunov Matrix
%
lmi_lyap = [g >= ZERO];
for t = 1 : N
    lmi_lyap_item = [X{t} >= ZERO];
    lmi_lyap = lmi_lyap + lmi_lyap_item;
end % for k
for t = 1 : N+1
    for v = 1 : nv
        lmi_lyap_item = [Q{t}{v} >= ZERO];
        lmi_lyap = lmi_lyap + lmi_lyap_item;
    end % for v
end % for k

% Robust Invariant Ellipsoid
%
lmi_rie = [];
for v = 1 : nv
    lmi_rie_item = [ [1, xk'; xk, Q{1}{v}] >= ZERO ];
    lmi_rie = lmi_rie + lmi_rie_item;
end % for v

% Convergency
%
lmi_conv = [];
%
for t = 1 : N
for v = 1 : nv
for vp = 1 : nv
for j = 1 : nj

lmi_conv_item = [ [X{t} + X{t}' - Q{t}{v}, (A{v}*X{t} + B{v}*(Y{t} - E{j}*Z{t}) )', (sqrt(Wx)*X{t})', (sqrt(Wu)*(Y{t} - E{j}*Z{t}))';...
    A{v}*X{t} + B{v}*(Y{t} - E{j}*Z{t}), Q{t+1}{vp}, ZEROx, ZEROxu;...
    sqrt(Wx)*X{t}, ZEROx, g*Ix, ZEROxu;...
    sqrt(Wu)*(Y{t} - E{j}*Z{t}), ZEROux, ZEROux, g*Iu] >= ZERO ];

lmi_conv = lmi_conv + lmi_conv_item;

end % for j
end % for vp
end % for v
end % for k

% Input Constraints
%
lmi_u_max = [];
%
if(isempty(u_max) == 0)
    %
    % L2-norm
    %
    lmi_u_max = [];
    for t = 1 : N
    for v = 1 : nv

    lmi_u_max_item = [ [ diag(u_max.^2), Y{t} - Z{t};...
        (Y{t} - Z{t})', X{t} + X{t}' - Q{t}{v} ] >= ZERO ];
    lmi_u_max = lmi_u_max + lmi_u_max_item;

    end % for v
    end % for k
    %
    % L1-norm
    %
    for t = 1 : N
    for v = 1 : nv

    lmi_u_max_item = [ [ U, Y{t} - Z{t};...
        (Y{t} - Z{t})', X{t} + X{t}' - Q{t}{v} ] >= ZERO ];
    lmi_u_max = lmi_u_max + lmi_u_max_item;

    end % for v
    end % for k
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

    lmi_x_max_item = [ [...
        X{t} + X{t}' - Q{t}{v},...
        (C{v}*(A{v}*X{t} + B{v}*(Y{t} + E{j}*Z{t})))';...
        (C{v}*(A{v}*X{t} + B{v}*(Y{t} + E{j}*Z{t}))),...
        diag(x_max.^2),...
        ] >= ZERO ];

    lmi_x_max = lmi_x_max + lmi_x_max_item;

    end % for j
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
for t = 1
    Xt = [X{t}, zeros(row(1),max(col)-col(1))];
    Yt = [Y{t}, zeros(row(2),max(col)-col(2))];
end % for k
gt = [g, zeros(row(3),max(col)-col(3))];
M  = [Xt; Yt; gt];
if(isempty(u_max) == 0) % For Input Constraints U_MAX
    Ut = [U, zeros(row(4),max(col)-col(4))];
    M  = [M; Ut];
end % if
%
% Handle the PDLF-matrices X in Case Feasibility-Check is Required
%
if(isequal(setup.chk_feas,'on'))
    %
    % Add NV-times (NX x NX)-dimmensional matrix X{v}
    %
    for t = 1 : N
        row = [row, nx, nu, nu];
        col = [col, nx, nx, nx];
        Xt = [X{t}, zeros(row(1),max(col)-nx)];
        Yt = [Y{t}, zeros(row(2),max(col)-nx)];
        Zt = [Z{t}, zeros(row(3),max(col)-nx)];
        M  = [M; Xt; Yt; Zt];
    end % for k
    %
    Qt = [];
    for t = 1 : N+1
    for v = 1 : nv
        row = [row, nx];
        col = [col, nx];
        Qt = [Q{t}{v}, zeros(nx,max(col)-nx)];
        M   = [M; Qt];
    end % for v
    end % for k
    
end % if
%
out = sdpvar(sum(row),max(col));


% Constraints
%
constr = lmi_lyap + lmi_rie + lmi_conv + lmi_u_max + lmi_x_max ;

% Optimizer Constraints
%
constr_optimizer = constr + [out == M];
