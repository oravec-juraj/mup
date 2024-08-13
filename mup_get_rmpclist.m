% MUP_GET_RMPCLIST
%
%   Function MUP_GET_RMPCLIST returnes list of avaliable RMPC methods.
%



function [list,kwd] = mup_get_rmpclist()

[mup_homepath,filename,ext] = fileparts(which('mup_get_rmpclist'));
path_rmpc_method = [mup_homepath,filesep,'rmpc_methods'];

[files,dirs,unknown,hiddenfiles] = sortls(path_rmpc_method,'info_');

for k = 1 : length(hiddenfiles)
    [pathstr,filename,ext] = fileparts(which(hiddenfiles{k}));
    if(isempty(filename) == 1)
        list{k,1} = [hiddenfiles{k},'_FILE_NOT_FOUND'];
        kwd{k,1} = [hiddenfiles{k},'_FILE_NOT_FOUND'];
    else
        cmd = ['temp = ',filename,';'];
        eval(cmd);
        list{k,1} = temp.name;
        kwd{k,1} = temp.keyword;
    end % if
end % for k

end % function