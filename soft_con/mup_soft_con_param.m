% MUP_SOFT_CON_PARAM
%
%   Function MUP_SOFT_CON_PARAM returnes parameters for soft-constrained
%   robust MPC design.
%
%   [u_sl,y_sl,Wsu,Wsy,Esu,Esy] = mup_soft_con_param(param)
%
%   where:
%
%   param(struct)       - input structure with following arrays:
%   u_sl(double:nsu)    - real-valued vector of input soft-constraints
%   y_sl(double:nsy)    - real-valued vector of output soft-constraints
%   Wsu(double:nsu,nsu) - real-valued weighting matrix of input soft-constraints
%   Wsy(double:nsy,nsy) - real-valued weighting matrix of output soft-constraints
%   Esu(double:nsu,nu)  - real-valued indication matrix of input soft-constraints
%   Esy(double:nsy,ny)  - real-valued indication matrix of output soft-constraints
%
%   juraj.oravec@stuba.sk
%
%   est.2016.03.05.
%
function [u_sl,y_sl,Wsu,Wsy,Esu,Esy] = mup_soft_con_param(param)

%% Soft constraints
u_sl = param.u_sl;
y_sl = param.y_sl;

%% weighting matrices of soft constraints
Wsu = param.Wsu;
Wsy = param.Wsy;

%% Indication of soft-constrained inputs and outputs
Esu = param.Esu;
Esy = param.Esy;

end % function
