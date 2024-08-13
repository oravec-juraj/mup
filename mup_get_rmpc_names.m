% MUP_GET_RMPC_NAMES
%
%   M-file MUP_GET_RMPC_NAMES generates the list of avaliable RMPC methods
%   and return the detail information about these RMPC methods.


% COMMAND: 
% >> ABOUT_$RMPC_NAME = INFO_$RMPC_NAME;

[list,kwd] = mup_get_rmpclist();

for mupvar_k = 1 : length(kwd)
    mupcmd{mupvar_k,1} = ['about_',kwd{mupvar_k},' = info_',kwd{mupvar_k},';'];
    eval(mupcmd{mupvar_k})
end % for mupvar_k % mupvar_k - is MUP variable "k", i.e., temporary counter

% about_kothare = info_kothare;
% about_cuzzola = info_cuzzola;
% about_mao = info_mao;
% about_wan = info_wan;
% about_cao = info_cao;
% about_ding = info_ding;
% about_li = info_li;
% about_huang = info_huang;
% about_shi = info_shi;
% about_zhang = info_zhang;
% about_wan_cao = info_wan_cao;
% about_wan_huang = info_wan_huang;
% about_mao_cao = info_mao_cao;
% about_mao_huang = info_mao_huang;
% etc.