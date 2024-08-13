% MUP_VERBOSE
%
%   Function MUP_VERBOSE manages the verbose messages.
%
%   juraj.oravec@stuba.sk
%
%


function mup_verbose(vbs_type,vbs,mes,varargin)

if(vbs >= vbs_type)
    cmd = ['disp(sprintf(''',mes,''','];
    for cnt = 1 : length(varargin)
        cmd = [cmd,'varargin{',num2str(cnt),'},'];
    end % for cnt
    cmd = [cmd(1:end-1),'));'];
    eval(cmd);
end % if

end % function