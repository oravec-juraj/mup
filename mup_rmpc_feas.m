% ------------- %
%
% MUP_RMPC_FEAS
%
% ------------- %
%


if(isequal(design.rmpc_method,about_kothare.name))
%
%% Kothare et al. (1996)
%
% Store Structure RESULTS
%
results.x = x; % xk
results.X = X_opt;
results.Y = Y_opt;
results.g = g_opt;

if(isempty(design.u_max) == 0)
	results.U = U_opt;
end % if

rmpc_block_ws.results = results;
%
[chkf,chk_eig] = feas_kothare(design,model,results,setup);
%
elseif(isequal(design.rmpc_method,about_cuzzola.name))
%
%% Cuzzola et al. (2002)
%
% Store Structure RESULTS
%
results.x = x; % xk
results.Q = Q_opt;
results.Y = Y_opt;
results.g = g_opt;

if(isempty(design.u_max) == 0)
    results.U = U_opt;
end % if

results.X = X_opt;
rmpc_block_ws.results = results;
%
[chkf,chk_eig] = feas_cuzzola(design,model,results,setup);
%
elseif(isequal(design.rmpc_method,about_mao.name))
%
%% Mao (2003)
%
% Store Structure RESULTS
%
results.x = x; % xk
results.Q = Q_opt;
results.Y = Y_opt;
results.g = g_opt;

if(isempty(design.u_max) == 0)
    results.U = U_opt;
end % if

results.X = X_opt;
rmpc_block_ws.results = results;
%
[chkf,chk_eig] = feas_mao(design,model,results,setup);
%
elseif(isequal(design.rmpc_method,about_wan.name))
%
%% Wan et al. (2003)
%
% Store Structure RESULTS
%
results.x = x; % xk
results.X = X_opt;
results.Y = Y_opt;
results.g = g_opt;

if(isempty(design.u_max) == 0)
	results.U = U_opt;
end % if

rmpc_block_ws.results = results;
%
[chkf,chk_eig] = feas_wan(design,model,results,setup);
%
elseif(isequal(design.rmpc_method,about_cao.name))
%
%% Cao et al. (2005)
%
% Store Structure RESULTS
%
results.x = x; % xk
results.X = X_opt;
results.Y = Y_opt;
results.Z = Z_opt;
results.g = g_opt;

if(isempty(design.u_max) == 0)
	results.U = U_opt;
end % if

rmpc_block_ws.results = results;
%
[chkf,chk_eig] = feas_cao(design,model,results,setup);
%
elseif(isequal(design.rmpc_method,about_ding.name))
%
%% Ding et al. (2007)
%
% Store Structure RESULTS
%
results.x = x; % xk
results.Q = Q_opt;
results.Y = Y_opt;
results.g = g_opt;

if(isempty(design.u_max) == 0)
    results.U = U_opt;
end % if

results.X = X_opt;
rmpc_block_ws.results = results;
%
[chkf,chk_eig] = feas_ding(design,model,results,setup);
%
elseif(isequal(design.rmpc_method,about_li.name))
%
%% Li et al. (2008)
%
% Store Structure RESULTS
%
results.x = x; % xk
results.X = X_opt;
results.Y = Y_opt;
results.g = g_opt;

if(isempty(design.u_max) == 0)
    results.U  = U_opt;
    results.Up = Up_opt;
end % if

results.Yp = Yp_opt;
rmpc_block_ws.results = results;
%
[chkf,chk_eig] = feas_li(design,model,results,setup);
%
elseif(isequal(design.rmpc_method,about_huang.name))
%
%% Huang et al. (2011)
%
% Store Structure RESULTS
%
results.x = x; % xk
results.X = X_opt;
results.Y = Y_opt;
results.Z = Z_opt;
results.g = g_opt;
results.gs = gs_opt;

if(isempty(design.u_max) == 0)
    results.U = U_opt;
end % if

rmpc_block_ws.results = results;
%
[chkf,chk_eig] = feas_huang(design,model,results,setup);
%
elseif(isequal(design.rmpc_method,about_shi.name))
%
%% Shi et al. (2013)
%
% Store Structure RESULTS
%
results.x = x; % xk
results.X = X_opt;
results.Y = Y_opt;
results.g = g_opt;
results.Xk = Xk_opt;
results.Yk = Yk_opt;
results.Qk = Qk_opt;
results.Zk = Zk_opt;

if(isempty(design.u_max) == 0)
	results.U = U_opt;
end % if

rmpc_block_ws.results = results;
%
[chkf,chk_eig] = feas_shi(design,model,results,setup);
%
%
elseif(isequal(design.rmpc_method,about_zhang.name))
%
%% Zhang et al. (2013)
%
% Store Structure RESULTS
%
results.x = x; % xk
results.X = X_opt;
results.Y = Y_opt;
results.Z = Z_opt;
results.g = g_opt;

if(isempty(design.u_max) == 0)
	results.U = U_opt;
end % if

results.W = W_opt;
results.Q = Q_opt;
rmpc_block_ws.results = results;
%
[chkf,chk_eig] = feas_zhang(design,model,results,setup);
%
elseif(isequal(design.rmpc_method,about_wan_cao.name))
%
%% NSO and ACIS (2015)
%
% Store Structure RESULTS
%
results.x = x; % xk
results.X = X_opt;
results.Y = Y_opt;
results.Z = Z_opt;
results.g = g_opt;

if(isempty(design.u_max) == 0)
	results.U = U_opt;
end % if

rmpc_block_ws.results = results;
%
[chkf,chk_eig] = feas_wan_cao(design,model,results,setup);
%
elseif(isequal(design.rmpc_method,about_wan_huang.name))
%
%% NSO and WACIS (2015)
%
% Store Structure RESULTS
%
results.x = x; % xk
results.X = X_opt;
results.Y = Y_opt;
results.Z = Z_opt;
results.g = g_opt;
results.gs = gs_opt;

if(isempty(design.u_max) == 0)
    results.U = U_opt;
end % if

rmpc_block_ws.results = results;
%
[chkf,chk_eig] = feas_wan_huang(design,model,results,setup);
%
%
elseif(isequal(design.rmpc_method,about_mao_cao.name))
%
%% PDLF and ACIS (2015)
%
% Store Structure RESULTS
%
results.x = x; % xk
results.X = X_opt;
results.Y = Y_opt;
results.Q = Q_opt;
results.Z = Z_opt;
results.g = g_opt;

if(isempty(design.u_max) == 0)
	results.U = U_opt;
end % if

rmpc_block_ws.results = results;
%
[chkf,chk_eig] = feas_mao_cao(design,model,results,setup);
%
%
elseif(isequal(design.rmpc_method,about_mao_huang.name))
%
%% PDLF and WACIS (2015)
%
% Store Structure RESULTS
%
results.x = x; % xk
results.X = X_opt;
results.Y = Y_opt;
results.Q = Q_opt;
results.Z = Z_opt;
results.g = g_opt;
results.gs = gs_opt;

if(isempty(design.u_max) == 0)
	results.U = U_opt;
end % if

rmpc_block_ws.results = results;
%
[chkf,chk_eig] = feas_mao_huang(design,model,results,setup);
%
%
elseif(isequal(design.rmpc_method,about_wan_zhang.name))
%
%% NSO and SDLF (2015)
%
% Store Structure RESULTS
%
results.x = x; % xk
results.X = X_opt;
results.Y = Y_opt;
results.Z = Z_opt;
results.g = g_opt;
results.W = W_opt;
results.Q = Q_opt;

if(isempty(design.u_max) == 0)
    results.U = U_opt;
end % if

rmpc_block_ws.results = results;
%
[chkf,chk_eig] = feas_wan_zhang(design,model,results,setup);


%% ------------------------------------------------------ %%
%
%% SOFT CONSTRAINTS
%
%% ------------------------------------------------------ %%

elseif(isequal(design.rmpc_method,about_kothare_soft_con.name))
%% KOTHARE SOFT-CON
%
% Store Structure RESULTS
%
results.x = x; % xk
results.X = X_opt;
results.Y = Y_opt;
results.g = g_opt;

if(isempty(design.u_max) == 0)
    results.U = U_opt;
end % if
if(isempty(design.param.u_sl) == 0)
    results.su = su_opt;
end % if
if(isempty(design.param.y_sl) == 0)
    results.sy = sy_opt;
end % if

rmpc_block_ws.results = results;
%
[chkf,chk_eig] = feas_kothare_soft_con(design,model,results,setup);

elseif(isequal(design.rmpc_method,about_wan_soft_con.name))
%% WAN SOFT-CON
%
% Store Structure RESULTS
%
results.x = x; % xk
results.X = X_opt;
results.Y = Y_opt;
results.g = g_opt;

if(isempty(design.u_max) == 0)
    results.U = U_opt;
end % if
if(isempty(design.param.u_sl) == 0)
    results.su = su_opt;
end % if
if(isempty(design.param.y_sl) == 0)
    results.sy = sy_opt;
end % if

rmpc_block_ws.results = results;
%
[chkf,chk_eig] = feas_wan_soft_con(design,model,results,setup);

elseif(isequal(design.rmpc_method,about_cao_soft_con.name))
%
%% CAO SOFT-CON
%
% Store Structure RESULTS
%
results.x = x; % xk
results.X = X_opt;
results.Y = Y_opt;
results.Z = Z_opt;
results.g = g_opt;

if(isempty(design.u_max) == 0)
    results.U = U_opt;
end % if
if(isempty(design.param.u_sl) == 0)
    results.su = su_opt;
end % if
if(isempty(design.param.y_sl) == 0)
    results.sy = sy_opt;
end % if

rmpc_block_ws.results = results;
%
[chkf,chk_eig] = feas_cao_soft_con(design,model,results,setup);

elseif(isequal(design.rmpc_method,about_wan_cao_soft_con.name))
%
%% NSO AND ACIS SOFT-CON
%
% Store Structure RESULTS
%
results.x = x; % xk
results.X = X_opt;
results.Y = Y_opt;
results.Z = Z_opt;
results.g = g_opt;

if(isempty(design.u_max) == 0)
    results.U = U_opt;
end % if
if(isempty(design.param.u_sl) == 0)
    results.su = su_opt;
end % if
if(isempty(design.param.y_sl) == 0)
    results.sy = sy_opt;
end % if

rmpc_block_ws.results = results;
%
[chkf,chk_eig] = feas_wan_cao_soft_con(design,model,results,setup);


%%
end % if