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


function data = info_kothare_soft_con()

data.name = 'Kothare et al. (1996) - Soft-Con';
data.keyword = 'kothare_soft_con';
data.ver = '20160305';
data.bib = ['@article{soft_con, author = {Juraj Oravec and Monika Bako\v{s}ov\''{a}}, title = {{Soft Constraints in the Robust MPC Design via LMIs}}, booktitle = {Proceedings of the American Control Conference 2016}, year = {2016}, address = {Boston, USA},}'];
data.author = 'Juraj Oravec';
data.ead = 'juraj.oravec@stuba.sk';
data.homepage = 'https://github.com/oravec-juraj/mup/wiki';

end % function
