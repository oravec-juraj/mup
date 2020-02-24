% MUP_GAMMA_OPT
%
%   Function MUP_GAMMA_OPT returnes the optimal value of optimizer GAMMA.
%   Note, that the value is available just in case, the feasibility check
%   is enabled. Otherwise, the returned value GAMMA_OPT == -1.
%
%   juraj.oravec@stuba.sk
%
%   est.2016.01.22.


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