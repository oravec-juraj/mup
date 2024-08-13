% INFO_WAN_CAO_SOFT_CON
%
%   Function INFO_WAN_CAO_SOFT_CON returnes basic information about
%   RMPC_CAO
%
%   data = info_wan_cao_soft_con
%
%   data:struct - is output structure with basic information
%
%   juraj.oravec@stuba.sk
%
%   est. 2016.03.05.
%


function data = info_wan_cao_soft_con()

data.name = 'NSO and ACIS - Soft-Con';
data.keyword = 'wan_cao_soft_con';
data.ver = '20160305';
data.bib = ['@article{soft_con, author = {Juraj Oravec and Monika Bako\v{s}ov\''{a}}, title = {{Soft Constraints in the Robust MPC Design via LMIs}}, booktitle = {Proceedings of the American Control Conference 2016}, year = {2016}, address = {Boston, USA},}'];
data.author = 'Juraj Oravec';
data.ead = 'juraj.oravec@stuba.sk';
data.homepage = 'https://github.com/oravec-juraj/mup/wiki';

end % function