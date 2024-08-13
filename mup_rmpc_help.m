% MUP_RMPC_HELP
%
%   Function MUP_RMPC_HELP opens the MUP-homepage in the browser.
%   Alternatively, if this option failed, this functino shows the
%   README-file in MATLAB COMMAND-WINDOW.
%
%   chk = mup_rmpc_help
%
%   where:
%
%   chk[class:double] - is the optional output flag
%
%   juraj.oravec@stuba.sk
%
%


function chk = mup_rmpc_help()

try
    %% Open MUP-homepage in Broser
    chk = web('https://github.com/oravec-juraj/mup/wiki', '-browser');
catch
    %% Write MUP_HELP into MATLAB COMMAND-WINDOW
    [fid,m] = fopen('README.md','r');
    tline = fgetl(fid);
    while ischar(tline)
        disp(tline)
        tline = fgetl(fid);
    end
    chk = fclose(fid); 
end % try

end % function