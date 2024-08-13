%% mup_rmpc_opt
%
%   M-file MUP_RMPC_OPT serves to construct the YALMIP/OPTIMIZER called 
%   RMPC_OPTIMIZER that solves the SDP of RMPC design.
%   Moreover, this m-file stores data into structures DESIGN, MODEL,
%   PROBLEM, SETUP, RMPC_BLOCK_WS[GLOBAL].


%% Construct the RMPC Optimizer
rmpc_optimizer = optimizer(constr_optimizer,obj,sdpsettings('verbose',0),xk, out(:));

%% Pack Data into structures DESIGN, MODEL, PROBLEM, SETUP, RMPC_BLOCK_WS[GLOBAL]
mup_rmpc_data