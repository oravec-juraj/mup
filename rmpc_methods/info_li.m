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

function data = info_li()

data.name = 'Li et al. (2008)';
data.keyword = 'li';
data.ver = '20140823';
data.bib = ['@inproceedings{li, author = {Z. Li and Y. Shi and D. Sun and L. Wang}, title = {{An Improved Constrained Robust Model Predictive Control Algorithm for Linear Systems With Polytopic Uncertainty}}, booktitle = {Proc. of the 2008 IEEE/ASME Int. Conf. on Advanced Intelligent Mechatronics}, year = {2008}, pages = {1272-1277},}'];
data.author = 'Juraj Oravec';
data.ead = 'juraj.oravec@stuba.sk';
data.homepage = 'https://github.com/oravec-juraj/mup/wiki';

end % function
