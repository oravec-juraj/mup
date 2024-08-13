% BENCHMARK_KOTHARE
%
%   Function BENCHMARK_KOTHARE load benchmark of paper Kothare et al.
%   (1996).
%	Consider uncertain linear state-space system in discrete-time domain
%	with sampling time Ts:
%
%   x(k+1) = A*x(k) + B*u(k),
%     y(k) = C*x(k),                x(0) = x0,
%   [A,B] \in convhull{[A{1},B{1}],[A{2},B{2}]}.
%
%   ||u|| <= u_max
%   ||x|| <= x_max 
%
%   stabilized to minimize:
%
%   min \sum_{i=0}^{\infty}( x(i)'*Wx*x(i) + u(i)'*Wu*u(i))
%
%   where:
%
%   A{1} = [
%     1.0000    0.1000
%          0    0.9900
%   ]
%
%   A{2} = [
%     1.0000    0.1000
%          0         0
%   ]
%
%   B{1} = B{2} = [
%          0
%    -0.1000
%   ]
% 
%   C{1} = C{2} = [
%          0    4.9500
%   ]
%
%   x0 = [
%     0.0500
%          0
%   ]
%
%   Ts = 1
%
%   u_max = 2
%
%   Wx = I
%
%   Wu = 0.00002
%
%   Use function MUP_EXPAND_RMPC_BLOCK_WS to expand the structure into
%   variables.
%
%   juraj.oravec@stuba.sk
%
%


function benchmark_kothare

global rmpc_block_ws

% Store Structure DESIGN
%
design.rmpc_method = [];
design.rmpc_kwd = [];
design.opt_type = [];
%
design.x0 = [0.05; 0];
design.Wu = 0.00002;
design.Wx = eye(2);
design.u_max = 2;
design.x_max = [];
design.param = [];
%
design.row = [];
design.col = [];
design.rmpc_optimizer = [];

% Store Structure MODEL
%
model.A = {[1, 0.10; 0, 0.99]; [1, 0.1; 0, 0]};
model.B = {[0; -0.1]; [0; -0.1]};
model.C = {[0, 4.95]; [0, 4.95]};
model.Ts = 1;

% Store Problem Sizes
%
problem.nv = length(model.A);
problem.nx = size(model.A{1},2);
problem.nu = size(model.B{1},2);

% Store Structure SETUP
%
setup.chk_feas = [];
setup.vbs = [];
setup.solver = [];
setup.chk_feas = [];
setup.feas_toler = [];
setup.vbsy = [];
setup.chk_soft_con = [];

% Store Structures into Global Work-Space
%
rmpc_block_ws.design = design;
rmpc_block_ws.problem = problem;
rmpc_block_ws.model = model;
rmpc_block_ws.setup = setup;

end 