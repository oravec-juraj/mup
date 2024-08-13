% mup_sdp
%
%   M-file MUP_SDP formulates the selected optimization problem in the form
%   of semidefinite programming (SDP) to evaluate the selected robust MPC
%   design method. This script calls m-file SDP_$RMPC_METHOD.
%
%   juraj.oravec@stuba.sk
%


%% Initialize RMPC Design Structures
mup_init_design

%% Expand structure PROBLEM
nv = problem.nv;
nx = problem.nx;
nu = problem.nu;

%% Formulate Command
cmd = ['sdp_',design.rmpc_kwd];

%% Check Command
if(exist(cmd) == 2)
    
    %% Evaluate Command
    eval(cmd)
    
else

    %% Error
    mup_verbose(0,1,' MUP:ERROR: File "%s" not found!',cmd)

end % if