% REFO_CAO
%


sdp_cao
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
end % if
