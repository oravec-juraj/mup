% --------- %
%
% FEAS_INIT
%
% --------- %

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

