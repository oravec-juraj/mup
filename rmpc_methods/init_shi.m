% INIT_SHI
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
        temp_cnt = 4; % 1 => X, 2 => Y, 3 => g, 4 => U
    else
        temp_cnt = 3; % 1 => X, 2 => Y, 3 => Z
    end % if
    %
    for t = 1 : N % Prediction horizon N (from PARAM)
        temp_cnt = temp_cnt + 1;
        Xk_opt{t} = mtx_opt{temp_cnt};
        temp_cnt = temp_cnt + 1;
        Yk_opt{t} = mtx_opt{temp_cnt};
        temp_cnt = temp_cnt + 1;
        Zk_opt{t} = mtx_opt{temp_cnt};
    end % for k
    %
    for t = 1 : N+1 % Prediction horizon N (from PARAM)
        for v = 1 : problem.nv; 
            temp_cnt = temp_cnt + 1;
            Qk_opt{t}{v} = mtx_opt{temp_cnt};
        end % for v
    end % for k
    %
    clear temp_cnt;
end % if
