% INFO_HUANG
%
%   Function INFO_HUANG returnes basic information about RMPC_HUANG
%
%   data = info_huang
%
%   data:struct - is output structure with basic information
%
%   juraj.oravec@stuba.sk
%
%   est. 2014.05.28.
%


function data = info_huang()

data.name = 'Huang et al. (2011)';
data.keyword = 'huang';
data.ver = '20140823';
data.bib = ['@article{huang, author = {H. Huang and D. Li and Z. Lin and Y. Xi}, title = {{An improved robust model predictive control design in the presence of actuator saturation}}, journal = {Automatica}, year = {2011}, volume = {47}, pages = {861-864},}'];
data.author = 'Juraj Oravec';
data.ead = 'juraj.oravec@stuba.sk';
data.homepage = 'https://github.com/oravec-juraj/mup/wiki';

end % function
