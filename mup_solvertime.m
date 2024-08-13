% MUP_SOLVERTIME
%
%   Function MUP_SOLVERTIME returnes the current value of solver-time.
%
%   juraj.oravec@stuba.sk
%
%   est.2016.01.29.



function t_sol = mup_solvertime(temp)

global rmpc_block_ws
t_sol = rmpc_block_ws.time.t_sol;

end % function