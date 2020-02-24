% CELL2MEAN
%
%   Function CELL2NOM_MTX returns mean-valued matrix of
%   cell-array matrix M.
%
%   Mmean = cell2mean(M)
%
%   where:
%
%   Mmean[cell] - is output mean-valued matrix of M
%   M[cell]     - is input cell-array matrix
%
%   Example:
%   M{1} = ones(2); M{2} = ones(2)*3;
%	Mmean = cell2mean(M)
%
%   juraj.oravec@stuba.sk
%
%   est.2015.02.06.
%
function Mmean = cell2mean(M)

rows = size(M{1,1},1);
cols = size(M{1,1},2);

M3d = cell2mtx3d(M);

for r = 1 : rows
    for c = 1 : cols
        Mmean(r,c) = mean(M3d(r,c,:));
    end % for c
end % for r

end % function

function M3d = cell2mtx3d(Mcell)
    for v = 1 : length(Mcell)
        M3d(:,:,v) = Mcell{v};
    end % for v
end % function