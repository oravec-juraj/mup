% INIT_DING
%


mtx_opt = vct2mtx(vct_opt,row,col);
X_opt = mtx_opt{1};
Y_opt = mtx_opt{2};
%
if(isequal(setup.chk_feas,'on'))
    g_opt = mtx_opt{3};
    %
    if(isempty(design.u_max) == 0)
        U_opt = mtx_opt{4};
        temp_cnt = 4;
    else
        temp_cnt = 3; % 1 => X, 2 => Y, 3 => g
    end % if
    %
    for v = 1 : problem.nv-1; % - 1 means that the nominal system (the last one) is removed
        Q_opt{v} = mtx_opt{temp_cnt + v};
    end % for v
    %
    clear temp_cnt;
end % if