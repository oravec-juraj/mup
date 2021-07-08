% MUP_RMPC_HELP
%
%   Function MUP_RMPC_HELP opens the MUP-homepage in the browser.
%   Alternatively, if this option failed, this functino shows the
%   README-file in MATLAB COMMAND-WINDOW.
%
%   chk = mup_rmpc_help
%
%   where:
%
%   chk[class:double] - is the optional output flag
%
%   juraj.oravec@stuba.sk
%
%   est.:2013.07.17.
%   rev.:2015.06.17.
%   rev.:2021.07.02.
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

function chk = mup_rmpc_help()

try
    %% Open MUP-homepage in Broser
    chk = web('https://github.com/oravec-juraj/mup/wiki', '-browser');
catch
    %% Write MUP_HELP into MATLAB COMMAND-WINDOW
    [fid,m] = fopen('README.md','r');
    tline = fgetl(fid);
    while ischar(tline)
        disp(tline)
        tline = fgetl(fid);
    end
    chk = fclose(fid); 
end % try

end % function