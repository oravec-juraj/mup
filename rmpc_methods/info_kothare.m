% INFO_KOTHARE
%
%   Function INFO_KOTHARE returnes basic information about RMPC_KOTHARE
%
%   data = info_ckothare
%
%   data:struct - is output structure with basic information
%
%   juraj.oravec@stuba.sk
%
%   est. 2014.05.27.
%


function data = info_kothare()

data.name = 'Kothare et al. (1996)';
data.keyword = 'kothare';
data.ver = '20140823';
data.bib = ['@article{kothare, author = {M. V. Kothare and V. Balakrishnan and M. Morari}, title = {{Robust Constrained Model Predictive Control Using Linear Matrix Inequalities}}, journal = {Automatica}, year = {1996}, volume = {32}, pages = {1361-1379},}'];
data.author = 'Juraj Oravec';
data.ead = 'juraj.oravec@stuba.sk';
data.homepage = 'https://github.com/oravec-juraj/mup/wiki';

end % function
