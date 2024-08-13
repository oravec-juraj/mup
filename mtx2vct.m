% MTX2VCT
%
%   Function MTX2VCT transforms matrices into single vector.
%
%   [vct,row,col] = mtx2vct(M_1,M_2,...,M_n)
%
%   where
%
%   vct:value - is output vector of all matrices elements
%   row:value - is output vector that includes list of number of matrices-rows
%   col:value - is output vector that includes list of number of matrices-columns
%   M_k:value - are input matrices to be transformed into vector
%
%   juraj.oravec@stuba.sk
%
%   est.2014.02.10.
%
%
%   See also VCT2MTX

% External Deps: None
% Internal Deps: add02mtz, add02mtz_item


function [vct,row,col] = mtx2vct(varargin)

Min = varargin;

% Vectors of Rows and Columns
%
for k = 1 : length(Min)
    row(k,1) = size(Min{k},1);
    col(k,1) = size(Min{k},2);
end % for k

% Add Zeros to Matrices
%
M0 = add02mtz(Min);

% Colapse Matrices into Single Matrix
%
M = [];
for k = 1 : size(M0)
    M = [M; M0{k}];
end % for k

% Create Vector of Matrix Elements
%
vct = M(:);

end % function


%%
function M = add02mtz(Min)
%
% Add Zeros To Cell-array of Matrices
%
n = length(Min);

% Find Matrix with Maximal  Number of Columns
%
col_max = -Inf;
for k = 1 : n
    col_item = size(Min{k},2);
    if(col_max < col_item)
        col_max = col_item;
    end % if
end % for n

% Add Zeros into All the Other Matrices
%
for k = 1 : n
    M{k,1} = add02mtz_item(Min{k},size(Min{k},1),col_max);
end % for n

end % function


%%
function M = add02mtz_item(Min,row_max,col_max)
%
% Add Zeros To Single Matrix
%
M = zeros(row_max,col_max);

[row,col] = size(Min);

M(1:row,1:col) = Min;

end % function