% MUP_RMPC_COUNTER
%
%   Function MUP_RMPC_COUNTER counts number of control steps
%
%   juraj.oravec@stuba.sk
%
%


function counter = mup_rmpc_counter(x)

t = x(1);
ts = x(2);

% Init
%
counter = floor(t/ts);

end % function