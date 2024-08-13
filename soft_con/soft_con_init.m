% SOFT_CON_INIT
%
%   Function SOFT_CON_INIT initialize the MUP's module to take into account
%   the soft constraints.
%
%   soft_con = soft_con_init(chk_soft_con,vbs,u_soft,y_soft,Wsu,Wsy)
%
%   juraj.oravec@stuba.sk
%
%   est.2016.03.20.
%


function soft_con = soft_con_init(chk_soft_con,vbs,u_soft,y_soft,Wsu,Wsy)

if(chk_soft_con == 1)

%% Soft-constrained control inputs
cnt = 0;
for k = 1 : length(u_soft)
    if(u_soft(k) ~= Inf)
        cnt = cnt + 1;
        u_sl(cnt,1) = u_soft(k);
        Esu(cnt,k) = 1;
    end % if
end % for k

%% Soft-constrained system outputs
cnt = 0;
for k = 1 : length(y_soft)
    if(y_soft(k) ~= Inf)
        cnt = cnt + 1;
        y_sl(cnt,1) = y_soft(k);
        Esy(cnt,k) = 1;
    end % if
end % for k

%% Function outputs:
soft_con.u_sl = u_sl;
soft_con.y_sl = y_sl;
soft_con.Wsu = Wsu;
soft_con.Wsy = Wsy;
soft_con.Esu = Esu;
soft_con.Esy = Esy;

else
%% Soft-constraints are not considered
soft_con.u_sl = [];
soft_con.y_sl = [];
soft_con.Wsu = [];
soft_con.Wsy = [];
soft_con.Esu = [];
soft_con.Esy = [];

mup_verbose(1,vbs,' MUP:BLOCK:SOFT-CON: Soft constraints initialized.')

end % function