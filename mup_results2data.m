% MUP_RESULTS2DATA
%
%   Function MUP_RESULTS2DATA returnes structure DATA with obtained
%   closed-loop results.
%
%   data = mup_results2data(x,u,cost,vtx)
%
%   where:
%
%   data[class:struct] - is output structure with obtained data
%   x[class:double]    - is input vector of system states to be stored
%   u[class:double]    - is input vector of system inputs to be stored
%   vtx[class:double]  - is input value of system vertex
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

function data = mup_results2data(x,u,cost,vtx,data)

%% Save Vertex-Results
data.x{vtx,1} = x;
data.u{vtx,1} = u;
data.cost{vtx,1} = cost;

end % function
