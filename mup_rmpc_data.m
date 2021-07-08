% MUP_RMPC_DATA
%
%   Script MUP_RMPC_DATA stores data into the structures.
%
%   juraj.oravec@stuba.sk
%
%   est.:2013.07.17
%   rev.:2015.10.24
%

% Copyright is with the following author(s):
%
% (c) 2016 Juraj Oravec, Slovak University of Technology in Bratislava,
% juraj.oravec@stuba.sk
% (c) 2016 Monika Bakosova, Slovak University of Technology in Bratislava,
% monika.bakosova@stuba.sk
% ------------------------------------------------------------------------------
% Legal note:
% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public
% License as published by the Free Software Foundation; either
% version 2.1 of the License, or (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
% General Public License for more details.
%
% You should have received a copy of the GNU General Public
% License along with this library; if not, write to the
% Free Software Foundation, Inc.,
% 59 Temple Place, Suite 330,
% Boston, MA 02111-1307 USA
%
% ------------------------------------------------------------------------------

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
