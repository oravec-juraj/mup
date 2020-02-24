% MUP_GET_RMPCLIST
%
%   Function MUP_GET_RMPCLIST returnes list of avaliable RMPC methods.
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

function [list,kwd] = mup_get_rmpclist()

[mup_homepath,filename,ext] = fileparts(which('mup_get_rmpclist'));
path_rmpc_method = [mup_homepath,filesep,'rmpc_methods'];

[files,dirs,unknown,hiddenfiles] = sortls(path_rmpc_method,'info_');

for k = 1 : length(hiddenfiles)
    [pathstr,filename,ext] = fileparts(which(hiddenfiles{k}));
    if(isempty(filename) == 1)
        list{k,1} = [hiddenfiles{k},'_FILE_NOT_FOUND'];
        kwd{k,1} = [hiddenfiles{k},'_FILE_NOT_FOUND'];
    else
        cmd = ['temp = ',filename,';'];
        eval(cmd);
        list{k,1} = temp.name;
        kwd{k,1} = temp.keyword;
    end % if
end % for k

end % function