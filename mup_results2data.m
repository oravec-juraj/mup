% MUP_RESULTS2DATA
%
%   Function MUP_RESULTS2DATA returnes structure DATA with obtained
%   closed-loop results.
%
%   data = mup_results2data(x,u,cost,vtx)
%
%   where:
%
%   data[class:struct] - is output structure with obtained data
%   x[class:double]    - is input vector of system states to be stored
%   u[class:double]    - is input vector of system inputs to be stored
%   vtx[class:double]  - is input value of system vertex
%
%   juraj.oravec@stuba.sk
%
%


function data = mup_results2data(x,u,cost,vtx,data)

%% Save Vertex-Results
data.x{vtx,1} = x;
data.u{vtx,1} = u;
data.cost{vtx,1} = cost;

end % function
