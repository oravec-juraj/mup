% INFO_DING
%
%   Function INFO_DING returnes basic information about RMPC_DING
%
%   data = info_cuzzola
%
%   data:struct - is output structure with basic information
%
%   juraj.oravec@stuba.sk
%
%   est. 2014.05.27.
%


function data = info_ding()

data.name = 'Ding et al. (2007)';
data.keyword = 'ding';
data.ver = '20140905';
data.bib = ['@article{cuzzola, author = {B. Ding and Y. Xi and M. T. Cychowski and T. O''Mahony}, title = {{Improving Off-line Approach to Robust MPC Based-on Nominal Performance Cost}}, journal = {Automatica}, year = {2007}, volume = {43}, pages = {158-163}}'];
data.author = 'Juraj Oravec';
data.ead = 'juraj.oravec@stuba.sk';
data.homepage = 'https://github.com/oravec-juraj/mup/wiki';

end % function
