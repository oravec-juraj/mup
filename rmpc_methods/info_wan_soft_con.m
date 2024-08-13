% INFO_WAN
%
%   Function INFO_WAN returnes basic information about RMPC_WAN
%
%   data = info_wan_soft_con
%
%   data:struct - is output structure with basic information
%
%   juraj.oravec@stuba.sk
%
%   est. 2014.05.27.
%


function data = info_wan_soft_con()

data.name = 'Wan et al. (2003) - Soft-Con';
data.keyword = 'wan_soft_con';
data.ver = '20160305';
data.bib = ['@article{soft_con, author = {Juraj Oravec and Monika Bako\v{s}ov\''{a}}, title = {{Soft Constraints in the Robust MPC Design via LMIs}}, booktitle = {Proceedings of the American Control Conference 2016}, year = {2016}, address = {Boston, USA},}'];
data.author = 'Juraj Oravec';
data.ead = 'juraj.oravec@stuba.sk';
data.homepage = 'https://github.com/oravec-juraj/mup/wiki';

end % function
