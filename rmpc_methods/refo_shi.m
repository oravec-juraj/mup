% REFO_MAO_HUANG
%


sdp_shi
sol = optimize(constr + [xk == xkk],obj,rmpc_block_ws.setup.op);
X_opt = value(X{1});
Y_opt = value(Y{1});
if(isequal(setup.chk_feas,'on'))
    for k = 1 : N
        Xk_opt{k} = value(X{k});
        Yk_opt{k} = value(Y{k});
        Zk_opt{k} = value(Z{k});
        g_opt = value(g);
    end % for k
    %
    if(isempty(design.u_max) == 0)
        U_opt = value(U);
    end % if
    %
    for k = 1 : N+1
        for v = 1 : nv
            Qk_opt{k}{v} = value(Q{k}{v});
        end % for v
    end % for k
end % if