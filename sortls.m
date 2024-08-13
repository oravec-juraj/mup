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