% MUP_RMPC_INIT
%
%   Function MUP_RMPC_INIT initialize the block RMPC for computing the
%   on-line robust MPC.
%
%   juraj.oravec@stuba.sk
%
%   est.:2013.07.17.
%   rev.:2014.09.05.
%   rev.:2014.09.08.
%   rev.:2016.03.05.
%   rev.:2021.07.02.

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

function mup_rmpc_init(design,model,setup)

tic

% ------------------------------------------------- %
%
% Expand Inputs
%
% ------------------------------------------------- %

% Expand Structure RMPC_BLOCK_WS
%
mup_expand_rmpc_block_ws
mup_verbose(2,vbs,' MUP:BLOCK:RMPC: Global variable RMPC_BLOCK_WS initialized.')


% ------------------------------------------------- %
%
% Parse Inputs
%
% ------------------------------------------------- %

% Verbose
%
if(isequal(vbs,'Silent'))
    vbs = 0;
elseif(isequal(vbs,'Loud'))
    vbs = 2;
else
    vbs = 1; % Normal Verbose Mode
end % if

% YALMIP Verbose
%
if(isequal(vbsy,'Silent'))
    vbsy = 0;
else
    vbsy = 2; % Laud Verbose Mode
end % if
%
% Optimization Setup
%
op = sdpsettings('solver',solver,'verbose',vbsy);
rmpc_block_ws.setup.op = op;


% ------------------------------------------------- %
%
% Preliminary Stage
%
% ------------------------------------------------- %
%
% Check YALMIP
%
chk_yalmip = exist('yalmip');
if(chk_yalmip ~= 2)
    mup_verbose(1,vbs,' MUP:BLOCK:RMPC: YALMIP Toolbox required, but not found!')
    error('!')
end % if
%
% Check SOLVER
%
chk_solver = exist(solver);
%
% Extension for solver MOSEK
if(isequal(solver,'MOSEK'))
    chk_solver = exist('mosekopt');
end % if
%
if(chk_solver ~= 2) & (chk_solver ~= 3) & (chk_solver ~= 7) % M-FILE (VAL==2) or MEX-FILE (VAL==3) or FOLDER_NAME (VAL==7)
    mup_verbose(1,vbs,' MUP:BLOCK:RMPC: Solver %s required, but not found!',solver)
	error('!')
end % if


% ------------------------------------------------- %
%
% RMPC DESIGN
%
% ------------------------------------------------- %

% MUP:BLOCK:RMPC - Set Current TAG
%
rmpc_tag = 'rmpc_tag';
rmpc_block_ws.setup.rmpc_tag = rmpc_tag;
mup_verbose(2,vbs,' MUP:BLOCK:RMPC: To block RMPC assigned TAG: %s',rmpc_tag)

% GLOBAL VARIABLE T_DES OF RMPC DESIGN RISING EDGE
%
t_des = 0;
rmpc_block_ws.time.t_des = t_des;

% Initial Value of Feasibility Check
chkf = -1;


% ------------------------------------------------- %
%
% SOFT-CON
%
% ------------------------------------------------- %
%
% Initialize module for to take into account the soft_constraints
if(chk_soft_con == 1)
    [param] = soft_con_init(chk_soft_con,vbs,param.u_sl,param.y_sl,param.Wsu,param.Wsy);
end % if

% ------------------------------------------------- %
%
% RMPC_METHOD
%
% ------------------------------------------------- %

% Get names of RMPC methods
%
mup_get_rmpc_names

xkk = x0;

if(isequal(rmpc_method,about_kothare.name))
%%
% --------------------------------------------------- %
%
% RMPC - KOTHARE ET AL. (1996)
%
% --------------------------------------------------- %
%
mup_verbose(1,vbs,' MUP:BLOCK:RMPC: Robust MPC design by %s',rmpc_method)

if(isequal(opt_type,'reformulation'))
    %
    % Reformulation
    %
    refo_kothare
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved (YALMIP: %s).',sol.info)
    %
elseif(isequal(opt_type,'initial'))
    %
    % Optimizer
    %
    sdp_kothare
    design_rmpc_optimizer
    init_kothare
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved and OPTIMIZER designed.')
    %
else
    error('MUP:BLOCK:RMPC: FATAL ERROR! Unable to design Robust MPC! (variable OPT_TYPE has unexpected value)')
end % if

F_opt = Y_opt*inv(X_opt);

% END - KOTHARE ET AL. (1996)


elseif(isequal(rmpc_method,about_cuzzola.name))
%%
% --------------------------------------------------- %
%
% RMPC - CUZZOLA ET AL. (2002)
%
% --------------------------------------------------- %
%
mup_verbose(1,vbs,' MUP:BLOCK:RMPC: Robust MPC design by %s',rmpc_method)

if(isequal(opt_type,'reformulation'))
    %
    % Reformulation
    %
    refo_cuzzola
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved (YALMIP: %s).',sol.info)
    %
elseif(isequal(opt_type,'initial'))
    %
    % Optimizer
    %
    sdp_cuzzola
    design_rmpc_optimizer
    init_cuzzola
    %
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved and OPTIMIZER designed.')
    %
else
    error('MUP:BLOCK:RMPC: FATAL ERROR! Unable to design Robust MPC! (variable OPT_TYPE has unexpected value)')
end % if

F_opt = Y_opt*inv(X_opt);


% END CUZZOLA ET AL. (2002)


elseif(isequal(rmpc_method,about_mao.name))
%%
% --------------------------------------------------- %
%
% RMPC - MAO (2003)
%
% --------------------------------------------------- %
%
mup_verbose(1,vbs,' MUP:BLOCK:RMPC: Robust MPC design by %s',rmpc_method)

if(isequal(opt_type,'reformulation'))
    %
    % Reformulation
    %
    refo_mao
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved (YALMIP: %s).',sol.info)
    %
elseif(isequal(opt_type,'initial'))
    %
    % Optimizer
    %
    sdp_mao
    design_rmpc_optimizer
    init_mao
    %
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved and OPTIMIZER designed.')
    %
else
    error('MUP:BLOCK:RMPC: FATAL ERROR! Unable to design Robust MPC! (variable OPT_TYPE has unexpected value)')
end % if

F_opt = Y_opt*inv(X_opt);


% END MAO (2003)


elseif(isequal(rmpc_method,about_wan.name))
%%
% --------------------------------------------------- %
%
% RMPC - WAN ET AL. (2003)
%
% --------------------------------------------------- %
%
mup_verbose(1,vbs,' MUP:BLOCK:RMPC: Robust MPC design by %s',rmpc_method)

if(isequal(opt_type,'reformulation'))
    %
    % Reformulation
    %
    refo_wan
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved (YALMIP: %s).',sol.info)
    %
elseif(isequal(opt_type,'initial'))
    %
    % Optimizer
    %
    sdp_wan
    design_rmpc_optimizer
    init_wan
    %
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved and OPTIMIZER designed.')
    %
else
    error('MUP:BLOCK:RMPC: FATAL ERROR! Unable to design Robust MPC! (variable OPT_TYPE has unexpected value)')
end % if

F_opt = Y_opt*inv(X_opt);

% END - WAN ET AL. (2003)


elseif(isequal(rmpc_method,about_cao.name))
%%
% --------------------------------------------------- %
%
% RMPC - CAO ET AL. (2005)
%
% --------------------------------------------------- %
%
mup_verbose(1,vbs,' MUP:BLOCK:RMPC: Robust MPC design by %s',rmpc_method)

if(isequal(opt_type,'reformulation'))
    %
    % Reformulation
    %
    refo_cao
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved (YALMIP: %s).',sol.info)
    %
elseif(isequal(opt_type,'initial'))
    %
    % Optimizer
    %
    sdp_cao
    design_rmpc_optimizer
    init_cao
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved and OPTIMIZER designed.')
    %
else
    error('MUP:BLOCK:RMPC: FATAL ERROR! Unable to design Robust MPC! (variable OPT_TYPE has unexpected value)')
end % if

F_opt = Y_opt*inv(X_opt);

% END CAO ET AL. (2005)


elseif(isequal(rmpc_method,about_ding.name))
%%
% --------------------------------------------------- %
%
% RMPC - DING ET AL. (2007)
%
% --------------------------------------------------- %
%
mup_verbose(1,vbs,' MUP:BLOCK:RMPC: Robust MPC design by %s',rmpc_method)

if(isequal(opt_type,'reformulation'))
    %
    % Reformulation
    %
    refo_ding
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved (YALMIP: %s).',sol.info)
    %
elseif(isequal(opt_type,'initial'))
    %
    % Optimizer
    %
    sdp_ding
    design_rmpc_optimizer
    init_ding
    %
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved and OPTIMIZER designed.')
    %
else
    error('MUP:BLOCK:RMPC: FATAL ERROR! Unable to design Robust MPC! (variable OPT_TYPE has unexpected value)')
end % if

F_opt = Y_opt*inv(X_opt);

% END DING ET AL. (2007)


elseif(isequal(rmpc_method,about_li.name))
%%
% --------------------------------------------------- %
%
% RMPC - LI ET AL. (2008)
%
% --------------------------------------------------- %
%
mup_verbose(1,vbs,' MUP:BLOCK:RMPC: Robust MPC design by %s',rmpc_method)

if(isequal(opt_type,'reformulation'))
    %
    % Reformulation
    %
    refo_li
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved (YALMIP: %s).',sol.info)
    %
elseif(isequal(opt_type,'initial'))
    %
    % Optimizer
    %
    sdp_li
    design_rmpc_optimizer
    init_li
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved and OPTIMIZER designed.')
    %
else
    error('MUP:BLOCK:RMPC: FATAL ERROR! Unable to design Robust MPC! (variable OPT_TYPE has unexpected value)')
end % if

F_opt = Y_opt*inv(X_opt);

% END LI ET AL. (2008)


elseif(isequal(rmpc_method,about_huang.name))
%%
% --------------------------------------------------- %
%
% RMPC - HUANG ET AL. (2011)
%
% --------------------------------------------------- %
%
mup_verbose(1,vbs,' MUP:BLOCK:RMPC: Robust MPC design by %s',rmpc_method)

beta = design.param; % Weighting Parameter BETA
if(isempty(beta) == 1)
    error(' MUP:BLOCK:RMPC: HUANG ET AL. (2011): Parameter BETA was not defined! Use PARAM to define it.')
end

if(isequal(opt_type,'reformulation'))
    %
    % Reformulation
    %
    refo_huang
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved (YALMIP: %s).',sol.info)
    %
elseif(isequal(opt_type,'initial'))
    %
    % Optimizer
    %
    sdp_huang
    design_rmpc_optimizer
    init_huang
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved and OPTIMIZER designed.')
    %
else
    error('MUP:BLOCK:RMPC: FATAL ERROR! Unable to design Robust MPC! (variable OPT_TYPE has unexpected value)')
end % if

F_opt = Y_opt*inv(X_opt);

% END HUANG ET AL. (2011)

%
elseif(isequal(rmpc_method,about_shi.name))
%%
% --------------------------------------------------- %
%
% RMPC - SHI ET AL. (2013)
%
% --------------------------------------------------- %
%
mup_verbose(1,vbs,' MUP:BLOCK:RMPC: Robust MPC design by %s',rmpc_method)

if(isempty(design.param) == 1)
    error(' MUP:BLOCK:RMPC: SHI ET AL. (2013): Prediction horizon N was not defined! Use PARAM to define it.')
end
    
N = design.param; % Prediction horizon N 

if(isequal(opt_type,'reformulation'))
    %
    % Reformulation
    %
    refo_shi
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved (YALMIP: %s).',sol.info)
    %
elseif(isequal(opt_type,'initial'))
    %
    % Optimizer
    %
    sdp_shi
    design_rmpc_optimizer
    init_shi
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved and OPTIMIZER designed.')
    %
else
    error('MUP:BLOCK:RMPC: FATAL ERROR! Unable to design Robust MPC! (variable OPT_TYPE has unexpected value)')
end % if

F_opt = Y_opt*inv(X_opt);

% END SHI ET AL. (2013)
%
%%
elseif(isequal(rmpc_method,about_zhang.name))
% --------------------------------------------------- %
%
% RMPC - ZHANG ET AL. (2013)
%
% --------------------------------------------------- %
%
mup_verbose(1,vbs,' MUP:BLOCK:RMPC: Robust MPC design by %s',rmpc_method)

if(isequal(opt_type,'reformulation'))
    %
    % Reformulation
    %
    refo_zhang
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved (YALMIP: %s).',sol.info)
    %
elseif(isequal(opt_type,'initial'))
    %
    % Optimizer
    %
    sdp_zhang
    design_rmpc_optimizer
    init_zhang
    %
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved and OPTIMIZER designed.')
    %
else
    error('MUP:BLOCK:RMPC: FATAL ERROR! Unable to design Robust MPC! (variable OPT_TYPE has unexpected value)')
end % if

F_opt = Y_opt*inv(X_opt);

% END ZHANG ET AL. (2013)

elseif(isequal(rmpc_method,about_wan_cao.name))
%%
% --------------------------------------------------- %
%
% RMPC - NSO AND ACIS (2015)
%
% --------------------------------------------------- %
%
mup_verbose(1,vbs,' MUP:BLOCK:RMPC: Robust MPC design by %s',rmpc_method)

if(isequal(opt_type,'reformulation'))
    %
    % Reformulation
    %
    refo_wan_cao
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved (YALMIP: %s).',sol.info)
    %
elseif(isequal(opt_type,'initial'))
    %
    % Optimizer
    %
    sdp_wan_cao
    design_rmpc_optimizer
    init_wan_cao
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved and OPTIMIZER designed.')
    %
else
    error('MUP:BLOCK:RMPC: FATAL ERROR! Unable to design Robust MPC! (variable OPT_TYPE has unexpected value)')
end % if

F_opt = Y_opt*inv(X_opt);

% END NSO AND ACIS (2015)

%
elseif(isequal(rmpc_method,about_wan_huang.name))
%%
% --------------------------------------------------- %
%
% RMPC - NSO AND WACIS (2015)
%
% --------------------------------------------------- %
%
mup_verbose(1,vbs,' MUP:BLOCK:RMPC: Robust MPC design by %s',rmpc_method)

beta = design.param; % Weighting Parameter BETA
if(isempty(beta) == 1)
    error(' MUP:BLOCK:RMPC: NSO AND WACIS: Parameter BETA was not defined! Use PARAM to define it.')
end

if(isequal(opt_type,'reformulation'))
    %
    % Reformulation
    %
    refo_wan_huang
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved (YALMIP: %s).',sol.info)
    %
elseif(isequal(opt_type,'initial'))
    %
    % Optimizer
    %
    sdp_wan_huang
    design_rmpc_optimizer
    init_wan_huang
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved and OPTIMIZER designed.')
    %
else
    error('MUP:BLOCK:RMPC: FATAL ERROR! Unable to design Robust MPC! (variable OPT_TYPE has unexpected value)')
end % if

F_opt = Y_opt*inv(X_opt);

% END NSO AND WACIS (2015)

%
elseif(isequal(rmpc_method,about_mao_cao.name))
%%
% --------------------------------------------------- %
%
% RMPC - PDLF AND ACIS (2015)
%
% --------------------------------------------------- %
%
mup_verbose(1,vbs,' MUP:BLOCK:RMPC: Robust MPC design by %s',rmpc_method)

if(isequal(opt_type,'reformulation'))
    %
    % Reformulation
    %
    refo_mao_cao
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved (YALMIP: %s).',sol.info)
    %
elseif(isequal(opt_type,'initial'))
    %
    % Optimizer
    %
    sdp_mao_cao
    design_rmpc_optimizer
    init_mao_cao
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved and OPTIMIZER designed.')
    %
else
    error('MUP:BLOCK:RMPC: FATAL ERROR! Unable to design Robust MPC! (variable OPT_TYPE has unexpected value)')
end % if

F_opt = Y_opt*inv(X_opt);

% END PDLF AND ACIS (2015)

%
elseif(isequal(rmpc_method,about_mao_huang.name))
%%
% --------------------------------------------------- %
%
% RMPC - PDLF AND WACIS (2015)
%
% --------------------------------------------------- %
%
mup_verbose(1,vbs,' MUP:BLOCK:RMPC: Robust MPC design by %s',rmpc_method)

beta = design.param; % Weighting Parameter BETA
if(isempty(beta) == 1)
    error(' MUP:BLOCK:RMPC: PDLF AND WACIS: Parameter BETA was not defined! Use PARAM to define it.')
end

if(isequal(opt_type,'reformulation'))
    %
    % Reformulation
    %
    refo_mao_huang
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved (YALMIP: %s).',sol.info)
    %
elseif(isequal(opt_type,'initial'))
    %
    % Optimizer
    %
    sdp_mao_huang
    design_rmpc_optimizer
    init_mao_huang
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved and OPTIMIZER designed.')
    %
else
    error('MUP:BLOCK:RMPC: FATAL ERROR! Unable to design Robust MPC! (variable OPT_TYPE has unexpected value)')
end % if

F_opt = Y_opt*inv(X_opt);

% END PDLF AND WACIS (2015)

%
elseif(isequal(rmpc_method,about_wan_zhang.name))
%%
% --------------------------------------------------- %
%
% RMPC - NSO AND SDLF (2015)
%
% --------------------------------------------------- %
%
mup_verbose(1,vbs,' MUP:BLOCK:RMPC: Robust MPC design by %s',rmpc_method)

if(isequal(opt_type,'reformulation'))
    %
    % Reformulation
    %
    refo_wan_zhang
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved (YALMIP: %s).',sol.info)
    %
elseif(isequal(opt_type,'initial'))
    %
    % Optimizer
    %
    sdp_wan_zhang
    design_rmpc_optimizer
    init_wan_zhang
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved and OPTIMIZER designed.')
    %
else
    error('MUP:BLOCK:RMPC: FATAL ERROR! Unable to design Robust MPC! (variable OPT_TYPE has unexpected value)')
end % if

F_opt = Y_opt*inv(X_opt);

% END NSO AND SDLF (2015)

%% ------------------------------------------------------ %%
%
%% SOFT CONSTRAINTS
%
%% ------------------------------------------------------ %%


elseif(isequal(rmpc_method,about_kothare_soft_con.name))
%%
% --------------------------------------------------- %
%
% RMPC - KOTHARE SOFT-CON
%
% --------------------------------------------------- %
%
mup_verbose(1,vbs,' MUP:BLOCK:RMPC: Robust MPC design by %s',rmpc_method)

if(isequal(opt_type,'reformulation'))
    %
    % Reformulation
    %
    refo_kothare_soft_con
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved (YALMIP: %s).',sol.info)
    %
elseif(isequal(opt_type,'initial'))
    %
    % Optimizer
    %
    sdp_kothare_soft_con
    design_rmpc_optimizer
    init_kothare_soft_con
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved and OPTIMIZER designed.')
    %
else
    error('MUP:BLOCK:RMPC: FATAL ERROR! Unable to design Robust MPC! (variable OPT_TYPE has unexpected value)')
end % if

F_opt = Y_opt*inv(X_opt);

% END KOTHARE SOFT-CON

elseif(isequal(rmpc_method,about_wan_soft_con.name))
%%
% --------------------------------------------------- %
%
% RMPC - WAN SOFT-CON
%
% --------------------------------------------------- %
%
mup_verbose(1,vbs,' MUP:BLOCK:RMPC: Robust MPC design by %s',rmpc_method)

if(isequal(opt_type,'reformulation'))
    %
    % Reformulation
    %
    refo_wan_soft_con
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved (YALMIP: %s).',sol.info)
    %
elseif(isequal(opt_type,'initial'))
    %
    % Optimizer
    %
    sdp_wan_soft_con
    design_rmpc_optimizer
    init_wan_soft_con
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved and OPTIMIZER designed.')
    %
else
    error('MUP:BLOCK:RMPC: FATAL ERROR! Unable to design Robust MPC! (variable OPT_TYPE has unexpected value)')
end % if

F_opt = Y_opt*inv(X_opt);

% END WAN SOFT-CON

elseif(isequal(rmpc_method,about_cao_soft_con.name))
%%
% --------------------------------------------------- %
%
% RMPC - CAO SOFT-CON
%
% --------------------------------------------------- %
%
mup_verbose(1,vbs,' MUP:BLOCK:RMPC: Robust MPC design by %s',rmpc_method)

if(isequal(opt_type,'reformulation'))
    %
    % Reformulation
    %
    refo_cao_soft_con
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved (YALMIP: %s).',sol.info)
    %
elseif(isequal(opt_type,'initial'))
    %
    % Optimizer
    %
    sdp_cao_soft_con
    design_rmpc_optimizer
    init_cao_soft_con
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved and OPTIMIZER designed.')
    %
else
    error('MUP:BLOCK:RMPC: FATAL ERROR! Unable to design Robust MPC! (variable OPT_TYPE has unexpected value)')
end % if

F_opt = Y_opt*inv(X_opt);

% END CAO SOFT-CON

elseif(isequal(rmpc_method,about_wan_cao_soft_con.name))
%%
% --------------------------------------------------- %
%
% RMPC - NSO AND ACIS SOFT-CON
%
% --------------------------------------------------- %
%
mup_verbose(1,vbs,' MUP:BLOCK:RMPC: Robust MPC design by %s',rmpc_method)

if(isequal(opt_type,'reformulation'))
    %
    % Reformulation
    %
    refo_wan_cao_soft_con
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved (YALMIP: %s).',sol.info)
    %
elseif(isequal(opt_type,'initial'))
    %
    % Optimizer
    %
    sdp_wan_cao_soft_con
    design_rmpc_optimizer
    init_wan_cao_soft_con
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved and OPTIMIZER designed.')
    %
else
    error('MUP:BLOCK:RMPC: FATAL ERROR! Unable to design Robust MPC! (variable OPT_TYPE has unexpected value)')
end % if

F_opt = Y_opt*inv(X_opt);

% END NSO AND ACIS SOFT-CON

elseif(isequal(rmpc_method,about_kothare_soft_con.name))
%%
% --------------------------------------------------- %
%
% RMPC - NSO AND ACIS SOFT-CON
%
% --------------------------------------------------- %
%
mup_verbose(1,vbs,' MUP:BLOCK:RMPC: Robust MPC design by %s',rmpc_method)

if(isequal(opt_type,'reformulation'))
    %
    % Reformulation
    %
    refo_wan_cao_soft_con
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved (YALMIP: %s).',sol.info)
    %
elseif(isequal(opt_type,'initial'))
    %
    % Optimizer
    %
    sdp_wan_cao_soft_con
    design_rmpc_optimizer
    init_wan_cao_soft_con
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: SDP problem solved and OPTIMIZER designed.')
    %
else
    error('MUP:BLOCK:RMPC: FATAL ERROR! Unable to design Robust MPC! (variable OPT_TYPE has unexpected value)')
end % if

F_opt = Y_opt*inv(X_opt);

% END NSO AND ACIS SOFT-CON


%%
end % if % END RMPC DESIGN

% SOLVERTIME
%
if(isequal(opt_type,'reformulation'))
    rmpc_block_ws.results.yalmip_sol = sol;
    t_sol = sol.solvertime;
end % 
rmpc_block_ws.time.t_sol = t_sol;

%%
% ------------------------------------------------- %
%
% RMPC Gain Matrix Design
%
% ------------------------------------------------- %
%
if(isnan(F_opt(1)))
    mup_verbose(1,vbs,' MUP:BLOCK:RMPC: Infeasible Problem of Robust MPC!')
    error(' MUP:RMPC_BLOCK: Infeasible Problem of Robust MPC!')
end
F_char = mat2strmat(F_opt);
mup_verbose(2,vbs,' MUP:BLOCK:RMPC: Designed robust MPC controller: %s',F_char)

%%
% ------------------------------------------------- %
%
% RMPC Feasibility Check
%
% ------------------------------------------------- %

if(isequal(chk_feas,'on'))
    %
    mup_verbose(2,vbs,' MUP:BLOCK:RMPC: FEASIBILITY_CHECK initialized...')
    t_feas1 = toc;
    x = x0; % Initial Conditions for Feasibility Check
    %
    mup_rmpc_feas
    %
    if(sum(chkf) > 0)
        %
        % DLQR Controller
        %
        F_opt = dlqr(A{end},B{end},Wx,Wu);
        F_char = mat2strmat(F_opt);
        mup_verbose(1,vbs,' MUP:BLOCK:RMPC: Feasibility check failed!');
        mup_verbose(1,vbs,' MUP:BLOCK:RMPC: Instead of Robust MPC has been designed LQ controller: %s',F_char)
    end % if
    t_feas2 = toc;
    t_feas = t_feas2 - t_feas1;
    mup_verbose(1,vbs,' MUP:BLOCK:RMPC: FEASIBILITY_CHECK: Termined. (%.2f sec)',t_feas)
end % if

%%
% ------------------------------------------------- %
%
% RMPC Interface
%
% ------------------------------------------------- %
%
mup_verbose(2,vbs,' MUP:BLOCK:RMPC: Interface initialization...')
mup_rmpc_interface(rmpc_tag,'rmpc_gain','Gain',F_char);
%
% FEAS Interface
%
if(chkf == -1)
	CHKF = chkf;
else
	CHKF = 1 - max(chkf);
end % if
mup_rmpc_interface(rmpc_tag,'feas_check_val','Value',CHKF);

t_init = toc;
mup_verbose(1,vbs,' MUP:BLOCK:RMPC: Initialization succesfully finished. (%.2f sec)',t_init)

end % function


% ----------------------------------------------------- %
%
% MAT2STRMAT
%
% ----------------------------------------------------- %
%
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