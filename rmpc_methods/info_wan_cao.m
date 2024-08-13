% INFO_WAN_CAO
%
%   Function INFO_WAN_CAO returnes basic information about RMPC_CAO
%
%   data = info_wan_cao
%
%   data:struct - is output structure with basic information
%
%   juraj.oravec@stuba.sk
%
%   est. 2014.09.08.
%


function data = info_wan_cao()

data.name = 'NSO and ACIS';
data.keyword = 'wan_cao';
data.ver = '20140908';
data.bib = ['@article{wan, author = {Z. Wan and M. V. Kothare}, title = {{Efficient Robust Constrained Model Predictive Control with a Time Varying Terminal Constraint Set}}, journal = {Automatica}, year = {2003}, volume = {48}, pages = {375-383}, }, @article{cao, author = {Y. Y. Cao and Z. Lin}, title =  {{Min-max MPC algorithm for LPV systems subject to input saturation}}, journal = {Control Theory and Applications, IEE Proceedings}, year = {2005}, volume = {153}, pages = {266-272},}'];
data.author = 'Juraj Oravec';
data.ead = 'juraj.oravec@stuba.sk';
data.homepage = 'https://github.com/oravec-juraj/mup/wiki';

end % function
