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

% Copyright is with the following author(s):
%
% (c) 2016 Juraj Oravec, Slovak University of Technology in Bratislava,
% juraj.oravec@stuba.sk
% (c) 2016 Monika Bakosova, Slovak University of Technology in Bratislava,
% monika.bakosova@stuba.sk
% ------------------------------------------------------------------------------
% Legal note:
% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public
% License as published by the Free Software Foundation; either
% version 2.1 of the License, or (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
% General Public License for more details.
%
% You should have received a copy of the GNU General Public
% License along with this library; if not, write to the
% Free Software Foundation, Inc.,
% 59 Temple Place, Suite 330,
% Boston, MA 02111-1307 USA
%
% ------------------------------------------------------------------------------

function data = info_mao_cao()

data.name = 'PDLF and ACIS';
data.keyword = 'mao_cao';
data.ver = '20150213';
data.bib = ['@article{mao, author = {J. W. Mao}, title = {{Robust Stabilization of Uncertain Time-Varying Discrete Systems and Comments on ``An Improved Approach for Constrained Robust Model Predictive Control''''}}, journal = {Automatica}, year = {2003}, volume = {39}, pages = {1109-1112},}, @article{cao, author = {Y. Y. Cao and Z. Lin}, title =  {{Min-max MPC algorithm for LPV systems subject to input saturation}}, journal = {Control Theory and Applications, IEE Proceedings}, year = {2005}, volume = {153}, pages = {266-272},}, @article{huang, author = {H. Huang and D. Li and Z. Lin and Y. Xi}, title = {{An improved robust model predictive control design in the presence of actuator saturation}}, journal = {Automatica}, year = {2011}, volume = {47}, pages = {861-864},}'];
data.author = 'Juraj Oravec';
data.ead = 'juraj.oravec@stuba.sk';
data.homepage = 'https://github.com/oravec-juraj/mup/wiki';

end % function
