% VCT2MTX
%
%   Function VCT2MTX vector into cell-array of original matrices.
%
%   mtx = vct2mtx(vct,row,col)
%
%   where
%3
%   mtx:cell   - is output cell-array of restored matrices
%   vct:value - is input vector of all matrices elements
%   row:value - is input vector that includes list of number of matrices-rows
%   col:value - is input vector that includes list of number of matrices-columns
%
%   juraj.oravec@stuba.sk
%
%   est.2014.02.10.
%
%   See also MTX2VCT

% External Deps: None
% Internal Deps: None

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

function mtx = vct2mtx(vct,row,col)

% Expand Matrix into Original Matrices
%
cnt = 0;
for k = 1 : sum(row) : length(vct)

cnt = cnt + 1;
for r = 1 : length(row)

    Mout{r,1}(:,cnt) = vct(k+sum(row(1:r-1)) : k+sum(row(1:r))-1 );

end % for r
end % for k

% Remove Added Zeros
%
for k = 1 : length(Mout)
    mtx{k,1} = Mout{k}(:,1:col(k));
end % for k

end % function