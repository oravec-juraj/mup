% INIT_WAN_CAO
%


mtx_opt = vct2mtx(vct_opt,row,col);
X_opt = mtx_opt{1};
Y_opt = mtx_opt{2};
%
if(isequal(setup.chk_feas,'on'))
    Z_opt = mtx_opt{3};
    g_opt = mtx_opt{4};
    %
    if(isempty(design.u_max) == 0)
        U_opt = mtx_opt{5};
    end % if
end % if
