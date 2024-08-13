% MUP_GAMMA_OPT
%
%   Function MUP_GAMMA_OPT returnes the optimal value of optimizer GAMMA.
%   Note, that the value is available just in case, the feasibility check
%   is enabled. Otherwise, the returned value GAMMA_OPT == -1.
%
%   juraj.oravec@stuba.sk
%
%   est.2016.01.22.



function gamma = mup_gamma_opt(chk_feas)

if(chk_feas == 0)|(chk_feas == 1)
    %
    % If feasibility check is enabled, i.e., CHK_FEAS == -1, then return GAMMA = GAMMA_OPT
    %
    global rmpc_block_ws
    gamma = rmpc_block_ws.results.g;    
else
    %
    % Otherwise assign GAMMA = -1
    %
    gamma = -1;
end % if 

end % function