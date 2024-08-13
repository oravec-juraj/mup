% ------------------------ %
%
% MUP_EXPAND_RMPC_BLOCK_WS
%
% ------------------------ %


global rmpc_block_ws

% Expand Structure RMPC_BLOCK_WS
%
design = rmpc_block_ws.design;
model = rmpc_block_ws.model;
problem = rmpc_block_ws.problem;
setup = rmpc_block_ws.setup;

% Expand Structure DESIGN
%
rmpc_method = design.rmpc_method;
opt_type = design.opt_type;
x0 = design.x0;
Wu = design.Wu;
Wx = design.Wx;
u_max = design.u_max;
x_max = design.x_max;
param = design.param;

% Expand Structure MODEL
%
A = model.A;
B = model.B;
C = model.C;
Ts = model.Ts;

% Expand Structure PROBLEM
%
nv = problem.nv;
nx = problem.nx;
nu = problem.nu;

% Expand Structure SETUP
%
vbs = setup.vbs;
solver = setup.solver;
chk_feas = setup.chk_feas;
feas_toler = setup.feas_toler;
vbsy = setup.vbsy;
chk_soft_con = setup.chk_soft_con;