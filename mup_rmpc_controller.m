% MUP_RMPC_CONTROLLER
%
%   Function MUP_RMPC_CONTROLLER computes on-line robust MPC gain matrix.
%
%   juraj.oravec@stuba.sk
%
%   est.:2013.07.17.
%   rev.:2014.09.05.
%   rev.:2014.09.08.
%   rev.:2014.09.30.
%   rev.:2014.12.15.
%   rev.:2016.03.05.

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

function [controller] = mup_rmpc_controller(in)

% Expand Structure RMPC_BLOCK_WS
%
mup_expand_rmpc_block_ws


% Parse Inputs
%
t = in(end-1);
ts = in(end);
x = in(1:end-2);
rmpc_block_ws.results.x = x; % xk
xkk = x; % xkk for refo_RMPC_NAME

t_des = rmpc_block_ws.time.t_des;

% Initial Values of Outputs
%
chkf = -1;
chk = 0;
controller = [-Inf];

% Run Controller Design Once a Sampling Time
%
if (mod(t,ts) == 0)&(t >= ts)&(t_des ~= t)
%
% Update T_DES
%
t_des = t;
rmpc_block_ws.time.t_des = t_des;


if(isequal(design.opt_type,'initial'))
%
% Optimizer Initialization
%
rmpc_optimizer = rmpc_block_ws.optimizer.rmpc_optimizer;
row = rmpc_block_ws.optimizer.row;
col = rmpc_block_ws.optimizer.col;
t_sol_start = toc;
vct_opt = rmpc_optimizer{x};
t_sol_finish = toc;
t_sol = t_sol_finish - t_sol_start; % Save SOLVERTIME
%
end % if


% ------------------------------------------------- %
%
% RMPC_METHOD
%
% ------------------------------------------------- %

% Get names of RMPC methods
%
mup_get_rmpc_names

%%
% --------------------------------------------------- %
%
% RMPC - KOTHARE ET AL. (1996)
%
% --------------------------------------------------- %
% 
% OPT_TYPE - REFORMULATION
%
if(isequal(design.rmpc_method,about_kothare.name))

    if(isequal(design.opt_type,'reformulation'))
        %
        refo_kothare

    elseif(isequal(design.opt_type,'initial'))
    %
    % OPT_TYPE - INITIAL = OPTIMIZER
    %
        init_kothare
    end % if

    % Design RMPC gain matrix F
    %
    F_opt = Y_opt*inv(X_opt);

% END - KOTHARE ET AL. (1996)

%%
% --------------------------------------------------- %
%
% RMPC - CUZZOLA ET AL. (2002)
%
% --------------------------------------------------- %
% 
% OPT_TYPE - REFORMULATION
%
elseif(isequal(design.rmpc_method,about_cuzzola.name))
    if(isequal(design.opt_type,'reformulation'))
        %
        refo_cuzzola

    elseif(isequal(design.opt_type,'initial'))
    %
    % OPT_TYPE - INITIAL = OPTIMIZER
    %
        init_cuzzola
    end % if

    % Design RMPC gain matrix F
    %
    F_opt = Y_opt*inv(X_opt)';

% END - CUZZOLA ET AL. (2002)

%%
% --------------------------------------------------- %
%
% RMPC - MAO (2003)
%
% --------------------------------------------------- %
% 
% OPT_TYPE - REFORMULATION
%
elseif(isequal(design.rmpc_method,about_mao.name))
    if(isequal(design.opt_type,'reformulation'))
        %
        refo_mao

    elseif(isequal(design.opt_type,'initial'))
    %
    % OPT_TYPE - INITIAL = OPTIMIZER
    %
        init_mao
    end % if

    % Design RMPC gain matrix F
    %
    F_opt = Y_opt*inv(X_opt)';

% END - MAO (2003)

%%
% --------------------------------------------------- %
%
% RMPC - WAN ET AL. (2003)
%
% --------------------------------------------------- %
% 
% OPT_TYPE - REFORMULATION
%
elseif(isequal(design.rmpc_method,about_wan.name))
    if(isequal(design.opt_type,'reformulation'))
        %
        refo_wan

    elseif(isequal(design.opt_type,'initial'))
    %
    % OPT_TYPE - INITIAL = OPTIMIZER
    %
        init_wan
    end % if

    % Design RMPC gain matrix F
    %
    F_opt = Y_opt*inv(X_opt);

% END - WAN ET AL. (2003)

%%
% --------------------------------------------------- %
%
% RMPC - CAO ET AL. (2005)
%
% --------------------------------------------------- %
% 
% OPT_TYPE - REFORMULATION
%
elseif(isequal(design.rmpc_method,about_cao.name))
    if(isequal(design.opt_type,'reformulation'))
        %
        refo_cao
        
    elseif(isequal(design.opt_type,'initial'))
    %
    % OPT_TYPE - INITIAL = OPTIMIZER
    %
        init_cao
    end % if

    % Design RMPC gain matrix F
    %
    F_opt = Y_opt*inv(X_opt);

% END - CAO ET AL. (2005)

%%
% --------------------------------------------------- %
%
% RMPC - DING ET AL. (2007)
%
% --------------------------------------------------- %
% 
% OPT_TYPE - REFORMULATION
%
elseif(isequal(design.rmpc_method,about_ding.name))
    if(isequal(design.opt_type,'reformulation'))
        %
        refo_ding

    elseif(isequal(design.opt_type,'initial'))
    %
    % OPT_TYPE - INITIAL = OPTIMIZER
    %
        init_ding
    end % if

    % Design RMPC gain matrix F
    %
    F_opt = Y_opt*inv(X_opt)';

% END - DING ET AL. (2007)

%%
% --------------------------------------------------- %
%
% RMPC - LI ET AL. (2008)
%
% --------------------------------------------------- %
% 
% OPT_TYPE - REFORMULATION
%
elseif(isequal(design.rmpc_method,about_li.name))
    if(isequal(design.opt_type,'reformulation'))
        %
        refo_li

    elseif(isequal(design.opt_type,'initial'))
    %
    % OPT_TYPE - INITIAL = OPTIMIZER
    %
        init_li

    end % if

    % Design RMPC gain matrix F
    %
    F_opt = Y_opt*inv(X_opt);

% END - LI ET AL. (2008)

%%
% --------------------------------------------------- %
%
% RMPC - HUANG ET AL. (2011)
%
% --------------------------------------------------- %
% 
% OPT_TYPE - REFORMULATION
%
elseif(isequal(design.rmpc_method,about_huang.name))

    beta = design.param; % Weighting Parameter BETA
    %
    if(isequal(design.opt_type,'reformulation'))
        %
        refo_huang
        
    elseif(isequal(design.opt_type,'initial'))
    %
    % OPT_TYPE - INITIAL = OPTIMIZER
    %
        init_huang
    end % if

    % Design RMPC gain matrix F
    %
    F_opt = Y_opt*inv(X_opt);

% END - HUANG ET AL. (2011)

%%
% --------------------------------------------------- %
%
% RMPC - ZHANG ET AL. (2013)
%
% --------------------------------------------------- %
% 
% OPT_TYPE - REFORMULATION
%
elseif(isequal(design.rmpc_method,about_zhang.name))
    if(isequal(design.opt_type,'reformulation'))
        %
        refo_zhang

    elseif(isequal(design.opt_type,'initial'))
    %
    % OPT_TYPE - INITIAL = OPTIMIZER
    %
        init_zhang
    end % if

    % Design RMPC gain matrix F
    %
    F_opt = Y_opt*inv(X_opt);

% END - ZHANG ET AL. (2013)

%%
% --------------------------------------------------- %
%
% RMPC - NSO AND ACIS (2015)
%
% --------------------------------------------------- %
% 
% OPT_TYPE - REFORMULATION
%
elseif(isequal(design.rmpc_method,about_wan_cao.name))
    if(isequal(design.opt_type,'reformulation'))
        %
        refo_wan_cao
        
    elseif(isequal(design.opt_type,'initial'))
    %
    % OPT_TYPE - INITIAL = OPTIMIZER
    %
        init_wan_cao
    end % if

    % Design RMPC gain matrix F
    %
    F_opt = Y_opt*inv(X_opt);

% END - NSO AND ACIS (2015)


%%
% --------------------------------------------------- %
%
% RMPC - NSO AND WACIS (2015)
%
% --------------------------------------------------- %
% 
% OPT_TYPE - REFORMULATION
%
elseif(isequal(design.rmpc_method,about_wan_huang.name))

    beta = design.param; % Weighting Parameter BETA
    %
    if(isequal(design.opt_type,'reformulation'))
        %
        refo_wan_huang
        
    elseif(isequal(design.opt_type,'initial'))
    %
    % OPT_TYPE - INITIAL = OPTIMIZER
    %
        init_wan_huang
    end % if

    % Design RMPC gain matrix F
    %
    F_opt = Y_opt*inv(X_opt);

% END - NSO AND WACIS (2015)


%%
% --------------------------------------------------- %
%
% RMPC - PDLF AND ACIS (2015)
%
% --------------------------------------------------- %
% 
% OPT_TYPE - REFORMULATION
%
elseif(isequal(design.rmpc_method,about_mao_cao.name))
    if(isequal(design.opt_type,'reformulation'))
        %
        refo_mao_cao
        
    elseif(isequal(design.opt_type,'initial'))
    %
    % OPT_TYPE - INITIAL = OPTIMIZER
    %
        init_mao_cao
    end % if

    % Design RMPC gain matrix F
    %
    F_opt = Y_opt*inv(X_opt);

% END - PDLF AND ACIS (2015)


%%
% --------------------------------------------------- %
%
% RMPC - PDLF AND WACIS (2015)
%
% --------------------------------------------------- %
% 
% OPT_TYPE - REFORMULATION
%
elseif(isequal(design.rmpc_method,about_mao_huang.name))
    
    beta = design.param; % Weighting Parameter BETA
    %
    if(isequal(design.opt_type,'reformulation'))
        %
        refo_mao_huang
        
    elseif(isequal(design.opt_type,'initial'))
    %
    % OPT_TYPE - INITIAL = OPTIMIZER
    %
        init_mao_huang
    end % if

    % Design RMPC gain matrix F
    %
    F_opt = Y_opt*inv(X_opt);

% END - PDLF AND WACIS (2015)

%%
% --------------------------------------------------- %
%
% RMPC - NSO AND SDLF (2015)
%
% --------------------------------------------------- %
% 
% OPT_TYPE - REFORMULATION
%
elseif(isequal(design.rmpc_method,about_wan_zhang.name))
    if(isequal(design.opt_type,'reformulation'))
        %
        refo_wan_zhang

    elseif(isequal(design.opt_type,'initial'))
    %
    % OPT_TYPE - INITIAL = OPTIMIZER
    %
        init_wan_zhang
    end % if

    % Design RMPC gain matrix F
    %
    F_opt = Y_opt*inv(X_opt);

% END - NSO AND SDLF (2015)


%% ------------------------------------------------------ %%
%
%% SOFT CONSTRAINTS
%
%% ------------------------------------------------------ %%

%%
% --------------------------------------------------- %
%
% RMPC - KOTHARE SOFT-CON
%
% --------------------------------------------------- %
% 
% OPT_TYPE - REFORMULATION
%
elseif(isequal(design.rmpc_method,about_kothare_soft_con.name))
    if(isequal(design.opt_type,'reformulation'))
        %
        refo_kothare_soft_con

    elseif(isequal(design.opt_type,'initial'))
    %
    % OPT_TYPE - INITIAL = OPTIMIZER
    %
        init_kothare_soft_con
    end % if

    % Design RMPC gain matrix F
    %
    F_opt = Y_opt*inv(X_opt);

% END - KOTHARE SOFT-CON

% --------------------------------------------------- %
%
% RMPC - WAN SOFT-CON
%
% --------------------------------------------------- %
% 
% OPT_TYPE - REFORMULATION
%
elseif(isequal(design.rmpc_method,about_wan_soft_con.name))
    if(isequal(design.opt_type,'reformulation'))
        %
        refo_wan_soft_con

    elseif(isequal(design.opt_type,'initial'))
    %
    % OPT_TYPE - INITIAL = OPTIMIZER
    %
        init_wan_soft_con
    end % if

    % Design RMPC gain matrix F
    %
    F_opt = Y_opt*inv(X_opt);

% END - WAN SOFT-CON

% --------------------------------------------------- %
%
% RMPC - CAO SOFT-CON
%
% --------------------------------------------------- %
% 
% OPT_TYPE - REFORMULATION
%
elseif(isequal(design.rmpc_method,about_cao_soft_con.name))

    if(isequal(design.opt_type,'reformulation'))
        %
        refo_cao_soft_con

    elseif(isequal(design.opt_type,'initial'))
    %
    % OPT_TYPE - INITIAL = OPTIMIZER
    %
        init_cao_soft_con
    end % if

    % Design RMPC gain matrix F
    %
    F_opt = Y_opt*inv(X_opt);

% END - CAO SOFT-CON


% --------------------------------------------------- %
%
% RMPC - NSO AND ACIS SOFT-CON
%
% --------------------------------------------------- %
% 
% OPT_TYPE - REFORMULATION
%
elseif(isequal(design.rmpc_method,about_wan_cao_soft_con.name))

    if(isequal(design.opt_type,'reformulation'))
        %
        refo_wan_cao_soft_con

    elseif(isequal(design.opt_type,'initial'))
    %
    % OPT_TYPE - INITIAL = OPTIMIZER
    %
        init_wan_cao_soft_con
    end % if

    % Design RMPC gain matrix F
    %
    F_opt = Y_opt*inv(X_opt);

% END - NSO AND ACIS SOFT-CON


%%
end % if


% SOLVERTIME
%
if(isequal(design.opt_type,'reformulation'))
    rmpc_block_ws.results.yalmip_sol = sol;
    t_sol = sol.solvertime;
end % 
rmpc_block_ws.time.t_sol = t_sol;

% --------------------------------------------------- %
%
% END - RMPC DESIGN
%
% --------------------------------------------------- %


if(isnan(F_opt(1)) ~= 1)

    chk = 1;
    controller = F_opt;
    F_char = mat2strmat(controller);

    % RMPC Interface
    %
	mup_rmpc_interface(setup.rmpc_tag,'rmpc_gain','Gain',F_char);
    
else

    chk = 0;

    % RMPC INTERFACE
    %
    controller = mup_rmpc_interface(setup.rmpc_tag,'rmpc_gain','Gain');
    controller = str2num(controller);
    mup_verbose(1,vbs,' MUP:RMPC_BLOCK: Infeasible Problem of Robust MPC (NaN)! Robust MPC hold at time t=%f!',t);
    
end % if


% Feasibility Check:
%
if(isequal(setup.chk_feas,'on'))&(chk == 1)
    %
    % Feasibility Check
    %
    mup_rmpc_feas
    %
    if(sum(chkf) > 0)
        %
        % Hold the Last Feasible Controller
        %
        block_name = find_system('tag','rmpc_tag');
        block_name = block_name{1};
        controller = get_param([block_name,'/rmpc_gain'],'Gain');
        controller = str2num(controller);
        mup_verbose(1,vbs,' MUP:RMPC_BLOCK: Feasibility check failed! Robust MPC hold at time t=%f!',t);
    end % if
    %
    % FEAS Interface
    %
    if(chkf == -1)
        CHKF = chkf;
    else
        CHKF = 1 - max(chkf);
    end % if
    mup_rmpc_interface(rmpc_block_ws.setup.rmpc_tag,'feas_check_val','Value',CHKF);
end % if

end % if


% RMPC Interface
%
controller = mup_rmpc_interface(rmpc_block_ws.setup.rmpc_tag,'rmpc_gain','Gain');
controller = str2num(controller);
controller = controller(:);

end % function

% ----------------------------------------------------- %
%
% MAT2STRMAT
%
% ----------------------------------------------------- %
function mes = mat2strmat(M)

n_row = size(M,1);
n_col = size(M,2);

mes = ['['];
for row = 1 : n_row
    for col = 1 : n_col
        mes = [mes,mat2str(M(row,col)),','];
    end
    mes = [mes(1:end-1),';'];
end
mes = [mes(1:end-1),']'];

end % function