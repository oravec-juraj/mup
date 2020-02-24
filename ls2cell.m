% LS2CELL
%
%   Function LS2CELL returnes cell-array of item included in DIRPATH.
%
%   [list,chk_dir] = ls2cell(dirpath)
%
%   where:
%
%   list:cell       - is output cell-array of items included in DIRPATH
%   chk_dir:value  - is output indicator vector of DIRECTORIES
%   dirpath:char    - is input path of directory to be listed, current
%                     direcotry is used, when input DIRPATH is omitted
%
%   juraj.oravec@stuba.sk
%
%   est.2014.03.06.
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

function [list,chk_dir] = ls2cell(dirpath)

% Default Value of Input
%
if(nargin == 0)
    dirpath = pwd;
end

% Initial Value of Output
%
list = {};

l = dir(dirpath);
nl = length(l);
for k = 1 : nl
    list{k,1}= l(k).name;
    chk_dir(k,1) = l(k).isdir;
end % for k

end % function