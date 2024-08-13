% INFO_CUZZOLA
%
%   Function INFO_CUZZOLA returnes basic information about RMPC_CUZZOLA
%
%   data = info_cuzzola
%
%   data:struct - is output structure with basic information
%
%   juraj.oravec@stuba.sk
%
%   est. 2014.05.27.
%


function data = info_cuzzola()

data.name = 'Cuzzola et al. (2002)';
data.keyword = 'cuzzola';
data.ver = '20140823';
data.bib = ['@article{cuzzola, author = {F. A. Cuzzola and J. C. Geromel and M. Morari}, title = {{An Improved Approach for Constrained Robust Model Predictive Control}}, journal = {Automatica}, year = {2002}, volume = {38}, pages = {1183-1189},}'];
data.author = 'Juraj Oravec';
data.ead = 'juraj.oravec@stuba.sk';
data.homepage = 'https://github.com/oravec-juraj/mup/wiki';

end % function
