% MUP_CLI_RMPC_METHOD
%
%   Function MUP_CLI_RMPC_METHOD is CLI that ons to select RMPC method
%   in user friendly way. 
%
%   [rmpc_method,rmpc_kwd] = mup_cli_rmpc_method()
%
%   where:
%
%   rmpc_method[class:char] - is output name of selected RMPC method
%   rmpc_kwd[class:char]    - is output keyword of selected RMPC method
%
%   juraj.oravec@stuba.sk
%
%


function [rmpc_method,rmpc_kwd] = mup_cli_rmpc_method()

%% List of Avaliable Methods
[rmpc_list, rmpc_kwds] = mup_get_rmpclist();
%
%% Verbose
disp(sprintf('\n List of available methods:'))
for k = 1 : length(rmpc_list)
    disp(sprintf(' %2d: %s',k,rmpc_list{k}))
end % for k
rmpc_list_num = Inf;
while ( (rmpc_list_num > length(rmpc_list)) | (rmpc_list_num < 1) | (mod(10*rmpc_list_num,10) ~= 0) )
    rmpc_list_num = input(' Select the RMPC method number: ');
    if (isempty(rmpc_list_num) == 1)
        rmpc_list_num = Inf;
    end % if
end

%% RMPC design method
rmpc_method = rmpc_list{rmpc_list_num};
rmpc_kwd = rmpc_kwds{rmpc_list_num};

%% Verbose
disp(sprintf('\n Selected RMPC design method: %s',rmpc_method))

end % function
