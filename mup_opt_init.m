% mup_opt_init
%
%   M-file MUP_OPT_INIT initializes the evaluation of RMPC_OPTIMIZER
%   constructed by YALMIP/OPTIMIZER. This script calls m-file
%   INIT_$RMPC_METHOD.
%
%   juraj.oravec@stuba.sk
%


%% Formulate Command
cmd = ['init_',design.rmpc_kwd];

%% Check Command
if(exist(cmd) == 2)

    %% Evaluate Command
    eval(cmd)
    
else

    %% Error
    mup_verbose(0,1,' MUP:ERROR: File "%s" not found!',cmd)

end % if