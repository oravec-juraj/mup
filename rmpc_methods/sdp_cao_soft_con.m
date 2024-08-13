% SDP_CAO_SOFT_CON
%
%   Script SDP_CAO_SOFT_CON add the soft constraints into SDP designed
%   by Cao et al. (2005).
%   This script extends an original script SDP_CAO, that is required.
%
%   Requires:
%   u_sl(double:nsu)    - real-valued vector of input soft-constraints
%   y_sl(double:nsy)    - real-valued vector of output soft-constraints
%   Wsu(double:nsu,nsu) - real-valued weighting matrix of input soft-constraints
%   Wsy(double:nsy,nsy) - real-valued weighting matrix of output soft-constraints
%   Esu(double:nsu,nu) - real-valued indication matrix of input soft-constraints
%   Esy(double:nsy,ny) - real-valued indication matrix of output soft-constraints
%
%   juraj.oravec@stuba.sk
%
%   est.2016.03.05.


%% Call original SDP
sdp_cao

%% Expand Structure PARAM

[u_sl,y_sl,Wsu,Wsy,Esu,Esy] = mup_soft_con_param(param);

%% Problem Size

nsu = length(u_sl);
nsy = length(y_sl);

%% Slack Variables

su = sdpvar(nsu,1);
sy = sdpvar(nsy,1);

%% Clack Variables Constraints

slack_var_u = [su >= ZERO];
slack_var_y = [sy >= ZERO];

%% Soft Input Contraints

lmi_u_sl = [];

if(isempty(u_sl) == 0)

lmi_u_sl = [[
    diag(u_sl).^2 + diag(su),...
    Esu*Y;...
    Y'*Esu',...
    X,...
] >= 0 ];

end % if isempty

%% Soft Output Contraints

lmi_y_sl = [];

if(isempty(y_sl) == 0)

for v = 1 : nv
   
lmi_y_sl = lmi_y_sl + [[
    X,...
    (A{v}*X + B{v}*Y)'*C{v}'*Esy';...
    Esy*C{v}*(A{v}*X + B{v}*Y),...
    diag(y_sl).^2 + diag(sy),...
] >= 0 ];

end

end % if isempty

%% OPTIMIZER - Update Subject to Soft Constraints

% Optimizer Matrices
%
row = [nx,nu,nu,1];
col = [nx,nx,nx,1];
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

%% Just For Soft Input Constraints U_SL
if((isempty(u_sl) == 0)&(isempty(y_sl) == 1))
    row = [row,nsu];
	col = [col,1];
    sut = [su, zeros(row(end),max(col)-col(end))];
    M  = [M; sut];
end % if
%% Just For Soft Output Constraints Y_SL
if((isempty(u_sl) == 1)&(isempty(y_sl) == 0))
    row = [row,nsy];
	col = [col,1];
    syt = [sy, zeros(row(end),max(col)-col(end))];
    M  = [M; syt];
end % if
%% For Soft Input and Output Constraints Y_SL
if((isempty(u_sl) == 0)&(isempty(y_sl) == 0))
    row = [row,nsu,nsy];
	col = [col,1,1];
    sut = [su, zeros(row(end-1),max(col)-col(end-1))];
    syt = [sy, zeros(row(end),max(col)-col(end))];
    M  = [M; sut; syt];
end % if
%
out = sdpvar(sum(row),max(col));

%% Add Soft Constriants into SDP
constr = constr + slack_var_u + slack_var_y + lmi_u_sl + lmi_y_sl;

%% Update Objective Function
if(isempty(u_sl) == 0)
    obj = obj + su'*diag(Wsu);
end % if
if(isempty(y_sl) == 0)
    obj = obj + sy'*diag(Wsy);
end % if

%% Optimizer Constraints

constr_optimizer = constr + [out == M];
