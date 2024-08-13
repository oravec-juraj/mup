% INIT_CAO
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
    end % if
    
        %% Soft Constraints Just on Inputs
    if((isempty(design.param.u_sl) == 0)&(isempty(design.param.y_sl) == 1))
        su_opt = mtx_opt{6};
    end % if
    
    %% Soft Constraints Just on Outputs
    if((isempty(design.param.u_sl) == 1)&(isempty(design.param.y_sl) == 0))
        sy_opt = mtx_opt{6};
    end % if
    
    %% Soft Constraints on Inputs and Outptus
    if((isempty(design.param.u_sl) == 0)&(isempty(design.param.y_sl) == 0))
        su_opt = mtx_opt{6};
        sy_opt = mtx_opt{7};
    end % if
    
end % if