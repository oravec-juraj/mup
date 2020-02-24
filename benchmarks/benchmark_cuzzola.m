% BENCHMARK_CUZZOLA
%
%   Function BENCHMARK_CUZZOLA load benchmark of paper Cuzzola et al.
%   (2002).
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
%     1.0000         0    0.1000         0
%          0    1.0000         0    0.1000
%    -0.0500    0.0500    1.0000         0
%     0.0500   -0.0500         0    1.0000
%   ]
%
%   A{2} = [
%     1.0000         0    0.1000         0
%          0    1.0000         0    0.1000
%    -1.0000    1.0000    1.0000         0
%     1.0000   -1.0000         0    1.0000
%   ]
%
%   B{1} = B{2} = [
%          0
%          0
%     0.1000
%          0
%   ]
% 
%   C{1} = C{2} = [
%      1     0     0     0
%      0     1     0     0
%      0     0     1     0
%      0     0     0     1
%   ]
%
%   x0 = [
%      1
%      1
%      0
%      0
%   ]
%
%   Ts = 1
%
%   u_max = 1
%
%   Wx = I
%
%   Wu = 1
%
%   Use function MUP_EXPAND_RMPC_BLOCK_WS to expand the structure into
%   variables.
%
%   juraj.oravec@stuba.sk
%
%   est.:2016.02.02
%

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

function benchmark_cuzzola

global rmpc_block_ws

% Store Structure DESIGN
%
design.rmpc_method = [];
design.rmpc_kwd = [];
design.opt_type = [];
%
design.x0 = [1; 1; 0; 0];
design.Wu = 1;
design.Wx = eye(4);
design.u_max = 1;
design.x_max = [];
design.param = [];
%
design.row = [];
design.col = [];
design.rmpc_optimizer = [];

% Store Structure MODEL
%
% Auxiliary parameters 
% Uncertain parameter: K \in [0.5, Km], where Km = 10
K_min = 0.5; % K \in [0.5, Km], where Km = 10
K_max = 10; % K \in [0.5, Km], where Km = 10
m1 = 1;
m2 = 1;
%
model.A = {[1, 0, 0.1, 0; 0, 1, 0, 0.1; -0.1*K_min/m1, 0.1*K_min/m1, 1, 0; 0.1*K_min/m2, -0.1*K_min/m2, 0, 1]; [1, 0, 0.1, 0; 0, 1, 0, 0.1; -0.1*K_max/m1, 0.1*K_max/m1, 1, 0; 0.1*K_max/m2, -0.1*K_max/m2, 0, 1]};
model.B = {[0; 0; 0.1/m1; 0]; [0; 0; 0.1/m1; 0]};
model.C = {eye(4); eye(4)};
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