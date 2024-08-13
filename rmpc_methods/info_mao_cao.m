% INFO_MAO_CAO
%
%   Function INFO_MAO_CAO returnes basic information about RMPC_CAO
%
%   data = info_mao_cao
%
%   data:struct - is output structure with basic information
%
%   juraj.oravec@stuba.sk
%
%   est. 2015.02.13.
%


function data = info_mao_cao()

data.name = 'PDLF and ACIS';
data.keyword = 'mao_cao';
data.ver = '20150213';
data.bib = ['@article{mao, author = {J. W. Mao}, title = {{Robust Stabilization of Uncertain Time-Varying Discrete Systems and Comments on ``An Improved Approach for Constrained Robust Model Predictive Control''''}}, journal = {Automatica}, year = {2003}, volume = {39}, pages = {1109-1112},}, @article{cao, author = {Y. Y. Cao and Z. Lin}, title =  {{Min-max MPC algorithm for LPV systems subject to input saturation}}, journal = {Control Theory and Applications, IEE Proceedings}, year = {2005}, volume = {153}, pages = {266-272},}, @article{huang, author = {H. Huang and D. Li and Z. Lin and Y. Xi}, title = {{An improved robust model predictive control design in the presence of actuator saturation}}, journal = {Automatica}, year = {2011}, volume = {47}, pages = {861-864},}'];
data.author = 'Juraj Oravec';
data.ead = 'juraj.oravec@stuba.sk';
data.homepage = 'https://github.com/oravec-juraj/mup/wiki';

end % function
