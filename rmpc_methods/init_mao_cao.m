% INIT_MAO_CAO
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
        temp_cnt = 5;
    else
        temp_cnt = 4; % 1 => X, 2 => Y, 3 => Z, g => 4
    end % if
    %
    for v = 1 : problem.nv;
        Q_opt{v} = mtx_opt{temp_cnt + v};
    end % for v
    %
    clear temp_cnt;
end % if