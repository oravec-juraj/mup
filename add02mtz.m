% Add Zeros To Cell-array of Matrices
%


function M = add02mtz(Min)

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