% INFO_WAN_HUANG
%
%   Function INFO_WAN_HUANG returnes basic information about RMPC_CAO
%
%   data = info_wan_huang
%
%   data:struct - is output structure with basic information
%
%   juraj.oravec@stuba.sk
%
%   est. 2014.09.26.
%


function data = info_wan_huang()

data.name = 'NSO and WACIS';
data.keyword = 'wan_huang';
data.ver = '20140908';
data.bib = ['@article{wan, author = {Z. Wan and M. V. Kothare}, title = {{Efficient Robust Constrained Model Predictive Control with a Time Varying Terminal Constraint Set}}, journal = {Automatica}, year = {2003}, volume = {48}, pages = {375-383}, }, @article{huang, author = {H. Huang and D. Li and Z. Lin and Y. Xi}, title = {{An Improved Robust Model Predictive Control Design in the Presence of Actuator Saturation}}, journal = {Automatica}, year = {2011}, volume = {47}, pages = {861-864}, }'];
data.author = 'Juraj Oravec';
data.ead = 'juraj.oravec@stuba.sk';
data.homepage = 'https://github.com/oravec-juraj/mup/wiki';

end % function
