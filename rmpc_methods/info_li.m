% INFO_LI
%
%   Function INFO_LI returnes basic information about RMPC_LI
%
%   data = info_li
%
%   data:struct - is output structure with basic information
%
%   juraj.oravec@stuba.sk
%
%   est. 2014.05.27.
%


function data = info_li()

data.name = 'Li et al. (2008)';
data.keyword = 'li';
data.ver = '20140823';
data.bib = ['@inproceedings{li, author = {Z. Li and Y. Shi and D. Sun and L. Wang}, title = {{An Improved Constrained Robust Model Predictive Control Algorithm for Linear Systems With Polytopic Uncertainty}}, booktitle = {Proc. of the 2008 IEEE/ASME Int. Conf. on Advanced Intelligent Mechatronics}, year = {2008}, pages = {1272-1277},}'];
data.author = 'Juraj Oravec';
data.ead = 'juraj.oravec@stuba.sk';
data.homepage = 'https://github.com/oravec-juraj/mup/wiki';

end % function
