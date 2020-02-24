% SORTLS
%
%   Function SORTLS sorts list of direcotory content into the directories
%   and files.
%
%   [files,dirs,unknown,hiddenfiles] = sortls(dirpath,hidesymbol)
%
%   files:cell      - is output list of files 
%   dirs:cell       - is output list of directories
%   unknown:cell    - is output list of unsorted items
%   hiddenfiles:cell- is output list of hidden files 
%   dirpath:char    - is input path of directory to be listed, current
%                     direcotry is used, when input DIRPATH is omitted
%   hidensymbol     - is symbol of hidden files, e.g. ".", "~", ect.
%
%   DEPS:EXTERNAL:  - LS2CELL
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

function [files,dirs,unknown,hiddenfiles] = sortls(dirpath,hidesymbol)

% Default Value of Input
%
if(nargin == 0)
    dirpath = pwd;
end
%
% To recognize Hidden Files
%
if(nargin == 2)
    chk_hiden = 1;
else
    chk_hiden = 0;
end

% Initial Values of Outputs
%
files = [];
dirs = [];
unknown = [];
hiddenfiles = [];

% Load LIST of directory-content and CHK_DIR
%
[list,chk_dir] = ls2cell(dirpath);

% Counters
%
cntF = 0;
cntD = 0;
cntU = 0;
cntH = 0;

for k = 1 : length(list)
    if (chk_dir(k) == 1)
        cntD = cntD + 1;
        dirs{cntD,1} = list{k};
    elseif(chk_dir(k) == 0)&(chk_hiden == 0)
        cntF = cntF + 1;
        files{cntF,1} = list{k};
    elseif(chk_dir(k) == 0)&(chk_hiden == 1)
        if(length(list{k}) > length(hidesymbol))
            if(list{k}(1:length(hidesymbol)) == hidesymbol)
                cntH = cntH + 1;
                hiddenfiles{cntH,1} = list{k};
            else
                cntF = cntF + 1;
                files{cntF,1} = list{k};
            end % if
        else
            cntF = cntF + 1;
            files{cntF,1} = list{k};
        end % if
    else
        cntU = cntU + 1;
        unknown{cntU,1} = list{k};
    end % if
end % for k

end % function