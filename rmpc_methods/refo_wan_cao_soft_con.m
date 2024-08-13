% REFO_WAN_CAO_SOFT_CON
%


sdp_wan_cao_soft_con
sol = optimize(constr + [xk == xkk],obj,rmpc_block_ws.setup.op);
X_opt = value(X);
Y_opt = value(Y);
%
if(isequal(setup.chk_feas,'on'))
    Z_opt = value(Z);
    g_opt = value(g);
    %
    if(isempty(design.u_max) == 0)
        U_opt = value(U);
    end % if
    
        %% Soft Constraints on Inputs
    if(isempty(design.param.u_sl) == 0)
        su_opt = value(su);
    end % if
    
    %% Soft Constraints on Outputs
    if(isempty(design.param.y_sl) == 0)
        sy_opt = value(sy);
    end % if
    
end % if
