% MUP_RMPC_INTERFACE
%
%   Function MUP_RMPC_INTERFACE set/returns RMPC gain matrix into/from
%   block gain RMPC/RMPC_GAIN.
%
%   juraj.oravec@stuba.sk
%
%   est.:2013.07.17.
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

function val = mup_rmpc_interface(rmpc_tag,block,atrib,val)

block_name = find_system('tag',rmpc_tag);
block_name = block_name{1};

if (nargin == 3) % GET VALUE
    val = get_param([block_name,'/',block],atrib);
else % SET VALUE
    set_param([block_name,'/',block],atrib,num2str(val))
end % if

end % function