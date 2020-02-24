% FIG_OPENED
%
%   Function FIG_OPENED returnes list of handles of all opened figures
%
%   h_fig_opened = fig_opened(h_fig_max)
%
%   where:
%
%   h_fig_opened    - is output vector of list of handles of all opened
%                     figures
%
%   h_fig_max       - is not required parameter of maximal addmisible
%                     figure handle (default value is ste to 100)
%
%   See also CLOSE_NOT
%
%   juraj.oravec@stuba.sk
%
%   2012.07.17.
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

function h_fig_opened = fig_opened(h_fig_max)

h_fig_opened = []; % Initial value of output

if(nargin == 0)
    h_fig_max = 1000; % Default value of maximal addmisible figure handle
    % h_fig_max = 2147483646;
end

for k = 1 : h_fig_max

    try
        
        temp = get(k);
        h_fig_opened = [h_fig_opened;k]; % list of handles of all opened figures
        
    catch
        
        % No action
        
    end % try
    
end % for k
    
end % function