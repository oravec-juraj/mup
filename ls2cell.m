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