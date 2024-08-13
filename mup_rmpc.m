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