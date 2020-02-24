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

function data = info_kothare()

data.name = 'Kothare et al. (1996)';
data.keyword = 'kothare';
data.ver = '20140823';
data.bib = ['@article{kothare, author = {M. V. Kothare and V. Balakrishnan and M. Morari}, title = {{Robust Constrained Model Predictive Control Using Linear Matrix Inequalities}}, journal = {Automatica}, year = {1996}, volume = {32}, pages = {1361-1379},}'];
data.author = 'Juraj Oravec';
data.ead = 'juraj.oravec@stuba.sk';
data.homepage = 'https://bitbucket.org/oravec/mup/wiki/Home';

end % function
