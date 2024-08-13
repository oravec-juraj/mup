% FIG_OPENED
%
%   Function FIG_OPENED returnes list of handles of all opened figures
%
%   h_fig_opened = fig_opened(h_fig_max)
%
%   where:
%
%   h_fig_opened    - is output vector of list of handles of all opened
%                     figures
%
%   h_fig_max       - is not required parameter of maximal addmisible
%                     figure handle (default value is ste to 100)
%
%   See also CLOSE_NOT
%
%   juraj.oravec@stuba.sk
%
%   2012.07.17.
%


function h_fig_opened = fig_opened(h_fig_max)

h_fig_opened = []; % Initial value of output

if(nargin == 0)
    h_fig_max = 1000; % Default value of maximal addmisible figure handle
    % h_fig_max = 2147483646;
end

for k = 1 : h_fig_max

    try
        
        temp = get(k);
        h_fig_opened = [h_fig_opened;k]; % list of handles of all opened figures
        
    catch
        
        % No action
        
    end % try
    
end % for k
    
end % function