% REFO_WAN_HUNAG
%


sdp_wan_huang
sol = optimize(constr + [xk == xkk],obj,rmpc_block_ws.setup.op);
X_opt = value(X);
Y_opt = value(Y);
%
if(isequal(setup.chk_feas,'on'))
    Z_opt = value(Z);
    g_opt = value(g);
    gs_opt = value(gs);
    %
    if(isempty(design.u_max) == 0)
        U_opt = value(U);
    end % if
end % if
