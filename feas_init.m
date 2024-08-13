% --------- %
%
% FEAS_INIT
%
% --------- %


% Initial Value of Outputs
%
chk = 0;
chk_eig = -Inf;


% Expand Structure DESIGN
%
rmpc_method =  design.rmpc_method;
x = results.x;
Wu = design.Wu;
Wx = design.Wx;
u_max = design.u_max;
x_max = design.x_max;

% Expand Structure MODEL
%
A = model.A;
B = model.B;
C = model.C;
Ts = model.Ts;


% Expand Structure SETUP
%
vbs = setup.vbs;
solver = setup.solver;
chk_feas = setup.chk_feas;
feas_toler = setup.feas_toler;
vbsy = setup.vbsy;

% Verbose
%
if(isequal(setup.vbs,'Silent'))
    vbs = 0;
elseif(isequal(setup.vbs,'Loud'))
    vbs = 2;
else
    vbs = 1; % Normal Verbose Mode
end % if

% Problem Size
%
nv = length(A);
nx = size(A{1},2);
nu = size(B{1},2);

% Precision Tolerance
%
ZERO = feas_toler;

% Counter
%
cnt = 0;

