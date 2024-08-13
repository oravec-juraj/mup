% DESIGN_RMPC_OPTIMIZER
%
%   Design of the RMPC_OPTIMIZER
%


rmpc_optimizer = optimizer(constr_optimizer,obj,rmpc_block_ws.setup.op, xk, out(:));
%
rmpc_block_ws.optimizer.rmpc_optimizer = rmpc_optimizer;
rmpc_block_ws.optimizer.row = row;
rmpc_block_ws.optimizer.col = col;
t_sol_start = toc;
vct_opt = rmpc_optimizer{x0};
t_sol_finish = toc;
t_sol = t_sol_finish - t_sol_start;