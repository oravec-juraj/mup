% CELL2value
%
%   Function CELL2value transforms cell-array into value column-vector.
%
%   vct = cell2value(in,pos,posCell)
%
%   where:
%
%   vct[class:double]     - is output vector
%   in[class:cell]        - is input cell array
%   pos[class:double]     - is input position of vector (default == 1)
%   posCell[class:double] - is input column-position of cell-array matrix (default == 1, i.e. cell-array is vector not matrix)
%
%   Example:
%   in={[1;11];[2;22];[3;33]};
%   vct = cell2double(in,2)
%
%   juraj.oravec@stuba.sk
%
%   est.2015.01.28.
%   rev.2015.02.05.
%
function vct = cell2double(in,pos,posCell)

if(nargin == 1)
    pos = 1;
    posCell = 1;
elseif(nargin == 2)
    posCell = 1;
end % if

for k = 1 : length(in)
    vct(k,1) = in{k,posCell}(pos);
end % for k

end % function