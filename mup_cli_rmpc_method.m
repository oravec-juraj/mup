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
%   est.:2015.06.16
%

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

function [rmpc_method,rmpc_kwd] = mup_cli_rmpc_method()

%% List of Avaliable Methods
[rmpc_list, rmpc_kwds] = mup_get_rmpclist();
%
%% Verbose
disp(sprintf('\n List of avaliable methods:'))
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
