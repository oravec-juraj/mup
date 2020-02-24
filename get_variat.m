% GET_VARIAT
%
%   Function GET_VARIAT returns a matrix of variations of zeros and ones
%   with required dimension of columns.
%
%   [num_bin, num_cols] = get_variat(k)
%
%   where
%
%   k           - is input dimension of column of returned matrix num_bin
%   num_bin     - is output matrix of variations of binary numbers
%   num_cols    - is output sum of columns of returned matrix num_bin
%
%   juraj.oravec@stuba.sk
%
%   2010.11.30.

function [num_bin, num_cols] = get_variat(k)

if (k <= 0)
    
    error(' GET_VARIAT: Input number K has to be positive number!');
    
end

num_cols = 2^k;

dim = length(dec2bin(num_cols)) - 1;

for n = 0 : num_cols - 1

    num_str = dec2bin(n,dim);
    
    for n2 = 1:length(num_str)
        
        num_bin(n2,n+1) = str2num(num_str(n2));
    
    end

end