% ------------------------ %
%
% MUP_EXPAND_RMPC_BLOCK_WS
%
% ------------------------ %

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