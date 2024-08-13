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


function data = info_zhang()

data.name = 'Zhang et al. (2013)';
data.keyword = 'zhang';
data.ver = '20141215';
data.bib = ['@inproceedings{ZW13,author = {L. Zhang and J. WANG and K. LI},title = {{Min-Max MPC for LPV Systems Subject to Actuator Saturation by a Saturation-Dependent Lyapunov Function}},booktitle = {Chinese Control Conference, Xi''an, China},year = {2013},pages = {4087-4092},} '];
data.author = 'Juraj Oravec';
data.ead = 'juraj.oravec@stuba.sk';
data.homepage = 'https://github.com/oravec-juraj/mup/wiki';

end % function
