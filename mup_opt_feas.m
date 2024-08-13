% MUP_OPT_FEAS
%
%   Script MUP_OPT_FEAS evaluates the feasibility check.
%
%   juraj.oravec@stuba.sk
%


%% Get RMPC Method Names
mup_get_rmpc_names

%% Initialize RMPC_OPTIMIZER
mup_opt_init

%% Pack the Optimization Results into the Structure RESULTS
mup_temp_var_x = x; % Store the variable "x"
x = x(:,end);
tic % Initialization
mup_rmpc_feas % Feasibility Check
x = mup_temp_var_x; % Reload the variable "x"
clear mup_temp_var_x % Remove the temporary variable
