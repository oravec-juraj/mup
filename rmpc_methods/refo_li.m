% REFO_LI
%


sdp_li
sol = optimize(constr + [xk == xkk],obj,rmpc_block_ws.setup.op);
X_opt = value(X);
Y_opt = value(Y);
%
if(isequal(setup.chk_feas,'on'))
    g_opt = value(g);
    %
    if(isempty(design.u_max) == 0)
        U_opt = value(U);
    end % if
    %
    for vp = 1 : nv
        Yp_opt{vp} = value(Yp{vp});
    end % for vp
    %
    for vp = 1 : nv
        Up_opt{vp} = value(Up{vp});
    end % for vp
end % if