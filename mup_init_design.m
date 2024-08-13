% MUP_INIT_DESIGN
%
%   Script MUP_INIT_DESIGN initializes structures for RMPC design.
%
%   juraj.oravec@stuba.sk
%
%


% Some Preset Parameters
%
if(exist('rmpc_kwd') == 0)
    rmpc_kwd = '';
end % if
if(exist('rmpc_optimizer') == 0)
    rmpc_optimizer = [];
end % if
if(exist('row') == 0)
    row = -Inf;
end % if
if(exist('col') == 0)
    col = -Inf;
end % if
if(exist('opt_type') == 0)
    opt_type = '';
end % if
if(exist('param') == 0)
    param = '';
end % if
if(exist('vbs') == 0)
    vbs = 1;
end % if
if(exist('vbsy') == 0)
    vbsy = 1;
end % if
if(exist('solver') == 0)|(exist('solver') == 7)
    solver = 'sedumi';
end % if
if(exist('chk_feas') == 0)
    chk_feas = 'on';
end % if
if(exist('feas_toler') == 0)
    feas_toler = -1e-6;
end % if

% Initialize Structure DATA
%
if(exist('data') == 0)
    data = [];
end % if

% Initialize Structure DESIGN
%
design.rmpc_method = rmpc_method;
design.rmpc_kwd = rmpc_kwd;
design.opt_type = opt_type;

% Store Problem Sizes
%
problem.nv = length(A);
problem.nx = size(A{1},2);
problem.nu = size(B{1},2);

% Initialize Structure SETUP
%
setup.chk_feas = chk_feas;
setup.vbs = vbs;
setup.solver = solver;
setup.feas_toler = feas_toler;
setup.vbsy = vbsy;

