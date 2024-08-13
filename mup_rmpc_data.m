% MUP_RMPC_DATA
%
%   Script MUP_RMPC_DATA stores data into the structures.
%
%   juraj.oravec@stuba.sk
%
%


global rmpc_block_ws

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
if(exist('solver') == 0)
    solver = '';
end % if
if(exist('chk_feas') == 0)
    chk_feas = 'on';
end % if
if(exist('feas_toler') == 0)
    feas_toler = -1e-6;
end % if
if(exist('chk_soft_con') == 0)
    chk_soft_con = 0;
end % if

% Store Structure DESIGN
%
design.rmpc_method = rmpc_method;
design.rmpc_kwd = rmpc_kwd;
design.opt_type = opt_type;
design.x0 = x0;
design.Wu = Wu;
design.Wx = Wx;
design.u_max = u_max;
design.x_max = x_max;
design.param = param;
design.row = row;
design.col = col;
design.rmpc_optimizer = rmpc_optimizer;

% Store Structure MODEL
%
model.A = A;
model.B = B;
model.C = C;
model.Ts = Ts;

% Store Problem Sizes
%
problem.nv = length(A);
problem.nx = size(A{1},2);
problem.nu = size(B{1},2);

% Store Structure SETUP
%
setup.chk_feas = chk_feas;
setup.vbs = vbs;
setup.solver = solver;
setup.chk_feas = chk_feas;
setup.feas_toler = feas_toler;
setup.vbsy = vbsy;
setup.chk_soft_con = chk_soft_con;

% Store Structures into Global Work-Space
%
rmpc_block_ws.design = design;
rmpc_block_ws.problem = problem;
rmpc_block_ws.model = model;
rmpc_block_ws.setup = setup;
