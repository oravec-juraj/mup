% Add Zeros To Cell-array of Matrices
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

function M = add02mtz(Min)

n = length(Min);

% Find Matrix with Maximal  Number of Columns
%
col_max = -Inf;
for k = 1 : n
    col_item = size(Min{k},2);
    if(col_max < col_item)
        col_max = col_item;
    end % if
end % for n

% Add Zeros into All the Other Matrices
%
for k = 1 : n
    M{k,1} = add02mtz_item(Min{k},size(Min{k},1),col_max);
end % for n

end % function


%%
function M = add02mtz_item(Min,row_max,col_max)
%
% Add Zeros To Single Matrix
%
M = zeros(row_max,col_max);

[row,col] = size(Min);

M(1:row,1:col) = Min;

end % function