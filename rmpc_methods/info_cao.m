% INFO_CAO
%
%   Function INFO_CAO returnes basic information about RMPC_CAO
%
%   data = info_cao
%
%   data:struct - is output structure with basic information
%
%   juraj.oravec@stuba.sk
%
%   est. 2014.05.27.
%


function data = info_cao()

data.name = 'Cao et al. (2005)';
data.keyword = 'cao';
data.ver = '20140823';
data.bib = ['@article{cao, author = {Y. Y. Cao and Z. Lin}, title =  {{Min-max MPC algorithm for LPV systems subject to input saturation}}, journal = {Control Theory and Applications, IEE Proceedings}, year = {2005}, volume = {153}, pages = {266-272},}'];
data.author = 'Juraj Oravec';
data.ead = 'juraj.oravec@stuba.sk';
data.homepage = 'https://github.com/oravec-juraj/mup/wiki';

end % function
