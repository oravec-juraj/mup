% VCT2MTX
%
%   Function VCT2MTX vector into cell-array of original matrices.
%
%   mtx = vct2mtx(vct,row,col)
%
%   where
%3
%   mtx:cell   - is output cell-array of restored matrices
%   vct:value - is input vector of all matrices elements
%   row:value - is input vector that includes list of number of matrices-rows
%   col:value - is input vector that includes list of number of matrices-columns
%
%   juraj.oravec@stuba.sk
%
%   est.2014.02.10.
%
%   See also MTX2VCT

% External Deps: None
% Internal Deps: None


function mtx = vct2mtx(vct,row,col)

% Expand Matrix into Original Matrices
%
cnt = 0;
for k = 1 : sum(row) : length(vct)

cnt = cnt + 1;
for r = 1 : length(row)

    Mout{r,1}(:,cnt) = vct(k+sum(row(1:r-1)) : k+sum(row(1:r))-1 );

end % for r
end % for k

% Remove Added Zeros
%
for k = 1 : length(Mout)
    mtx{k,1} = Mout{k}(:,1:col(k));
end % for k

end % function