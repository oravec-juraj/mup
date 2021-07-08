% INFO_ZHANG
%
%   Function INFO_ZHANG returnes basic information about RMPC_CAO
%
%   data = info_zhang
%
%   data:struct - is output structure with basic information
%
%   juraj.oravec@stuba.sk
%
%   est. 2014.12.15.
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

function data = info_wan_zhang()

data.name = 'NSO and SDLF';
data.keyword = 'wan_zhang';
data.ver = '20150216';
data.bib = ['@article{wan, author = {Z. Wan and M. V. Kothare}, title = {{Efficient Robust Constrained Model Predictive Control with a Time Varying Terminal Constraint Set}}, journal = {Automatica}, year = {2003}, volume = {48}, pages = {375-383},}, @inproceedings{ZW13,author = {L. Zhang and J. WANG and K. LI},title = {{Min-Max MPC for LPV Systems Subject to Actuator Saturation by a Saturation-Dependent Lyapunov Function}},booktitle = {Chinese Control Conference, Xi''an, China},year = {2013},pages = {4087-4092},} '];
data.author = 'Juraj Oravec';
data.ead = 'juraj.oravec@stuba.sk';
data.homepage = 'https://github.com/oravec-juraj/mup/wiki';

end % function
