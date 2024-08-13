% INFO_MAO_HUANG
%
%   Function INFO_MAO_HUNAG returnes basic information about RMPC_MAO
%
%   data = info_mao_huang
%
%   data:struct - is output structure with basic information
%
%   juraj.oravec@stuba.sk
%
%   est. 2015.02.16.
%


function data = info_mao_huang()

data.name = 'PDLF and WACIS';
data.keyword = 'mao_huang';
data.ver = '20150216';
data.bib = ['@article{mao, author = {J. W. Mao}, title = {{Robust Stabilization of Uncertain Time-Varying Discrete Systems and Comments on ``An Improved Approach for Constrained Robust Model Predictive Control''''}}, journal = {Automatica}, year = {2003}, volume = {39}, pages = {1109-1112}, }'];
data.author = 'Juraj Oravec';
data.ead = 'juraj.oravec@stuba.sk';
data.homepage = 'https://github.com/oravec-juraj/mup/wiki';

end % function
