% INFO_SHI
%
%   Function INFO_SHI returnes basic information about RMPC_SHI
%
%   data = info_shi
%
%   data:struct - is output structure with basic information
%
%   juraj.oravec@stuba.sk
%
%   est. 2021.07.02.
%


function data = info_huang()

data.name = 'Shi et al. (2013)';
data.keyword = 'shi';
data.ver = '20210702';
data.bib = ['@article{shi, author = {T. Shi and H. Su and J. Chu}, title = {{An improved model predictive control for uncertain systems with input constraints}}, journal = {Journal of Franklin Institute}, year = {2013}, volume = {350}, pages = {2757-2768},}'];
data.author = 'Juraj Oravec';
data.ead = 'juraj.oravec@stuba.sk';
data.homepage = 'https://github.com/oravec-juraj/mup/wiki';

end % function
