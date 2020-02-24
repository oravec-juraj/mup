% MUP_RMPC
%
%   Function MUP_RMPC evaluates closed-llop robust MPC using the
%   YALMIP/Optimizer. 
%
%   [u,F,vct_opt] = mup_rmpc(x,design)
%
%   where:
%
%   u[class:double]       - is output control action
%   F[class:double]       - is gain matrix of state-feedback control law
%   vct_opt[class:double] - is output vector of raw optimizers
%   x[class:double]       - is input state vector
%   design[class:struct]  - is input structure of RMPC design, where:
%   design.rmpc_optimizer[class:optimizer] - is input YALMIP/OPTIMIZER
%   design.row[class:double] - is number of rows of optimizer matrix M
%   design.col[class:double] - is number of columns of optimizer matrix M

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

function [u,F,vct_opt] = mup_rmpc(x,design)

%% Expand the Structure DESIGN
rmpc_optimizer = design.rmpc_optimizer;
row = design.row;
col = design.col;

%% Solve SDP Using YALMIP/OPTIMIZER
vct_opt = rmpc_optimizer{x};

%% Recover Optimized Matrix M Defined in SDP_$RMPC_NAME
mtx_opt = vct2mtx(vct_opt,row,col);

%% Recover the Optimized Matrices
X_opt = mtx_opt{1};
Y_opt = mtx_opt{2};
g_opt = mtx_opt{3};

%% Evaluate the Parametrized Gain Matrix F 
F = Y_opt*X_opt^(-1);

%% Control Law
u = F*x;

end % function