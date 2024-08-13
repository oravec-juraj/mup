% ------------------ %
%
% FEAS_INIT_SOFT_CON
%
% ------------------ %
%
%   Extension of script FEAS_INIT subject to soft constraints
%
%   juraj.oravec@stuba.sk
%


%% Call for Soft Constraints Setup
[u_sl,y_sl,Wsu,Wsy,Esu,Esy] = mup_soft_con_param(design.param);
