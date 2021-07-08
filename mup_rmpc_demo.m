% MUP_RMPC_SOFT_CON_DEMO
%
%   M-file MUP_RMPC_DEMO demonstrates the basic features of inline robust
%   MPC design by MUP toolbox.
%
%   juraj.oravec@stuba.sk
%
%   est.:2015.06.17.
%   rev.:2016.12.07.


% Copyright is with the following author(s):
%
% (c) (2015) Juraj Oravec, Slovak University of Technology in Bratislava,
% juraj.oravec@stuba.sk
% (c) (2015) Monika Bakosova, Slovak University of Technology in Bratislava,
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

%% Step 1: Define Uncertain System

% 1st Vertex
A{1,1} = [0.93, 0.51; 0.38, 0.83];
B{1,1} = [-1.45; -0.70];
C{1,1} = [2, 0; 0, 2];
% 2nd Vertex
A{2,1} = [0.06, 0.26; 1.80, 0.87];
B{2,1} = [-1.45; -0.70];
C{2,1} = [2, 0; 0, 2];
% Nominal System
A{3,1} = [0.50, 0.39; 1.10, 0.85];
B{3,1} = [-1.45; -0.70];
C{3,1} = [1, 0; 0, 1];
% Sampling Time
Ts = 1;

%% Step 2: Robust MPC Setup

%% System Initial Conditions
x0 = [3;0];

%% Input and State Constraints
u_max = [10];
x_max = [10;10];

%% Cost Function Weight Matrices
Wx = eye(2);
Wu = eye(1);

%% Alternatively, except of Stpes 1,2, you can load the benchmark system here
% benchmark_cuzzola % Load benchmark system
% mup_expand_rmpc_block_ws % Expand its variables

%% Soft-Constraints Params
%
u_sl = 0.4;
y_sl = [1;0.5];
Wsu = Wu*1e4;
Wsy = Wx*1e2;
Esu = eye(1);
Esy = eye(2);
%
param.u_sl = u_sl;
param.y_sl = y_sl;
param.Wsu = Wsu;
param.Wsy = Wsy;
param.Esu = Esu;
param.Esy = Esy;

%% on/off Feasibility Chcek
chk_feas = 'on'; % Enable Feasibility Chcek
% chk_feas = 'off'; % Disable Feasibility Chcek

%% Select RMPC method Using CLI
[rmpc_method,rmpc_kwd] = mup_cli_rmpc_method;

%% Additional RMPC Tunning Parameter
if( (isequal(rmpc_method,'Huang et al. (2011)')) | (isequal(rmpc_method,'PDLF and ACIS')) | (isequal(rmpc_method,'PDLF and WACIS')) )
    beta=1e3;
elseif ( (isequal(rmpc_method,'Shi et al. (2013)')) )
    N = 3; % Predictin horizon
    param = N;
end % if


%% Step 3: SDP Formulation
mup_sdp


%% Step 4: RMPC_OPTIMIZER Design

% Construct the RMPC_OPTMIZER and Store Data into structures DESIGN, MODEL, PROBLEM, SETUP, RMPC_BLOCK_WS[GLOBAL]
mup_rmpc_opt


%% Step 5: Closed-loop Control Performance

%% Number of Control Steps
nk = 10;
%
for vtx = 1 : nv

%% Initialization
disp(sprintf('\n Vertex processing: %d of %d',vtx,nv))
x(:,1) = x0;

for k = 1 : nk

%% Current State Measure
xk = x(:,k);

%% Closed-Loop RMPC using YALMIP/Optimizer
[u(:,k),F{k},vct_opt] = mup_rmpc(xk,design);

%% Feasibility Check
if(isequal(setup.chk_feas,'on'));
    mup_opt_feas
end % if

%% Verbose
disp(sprintf(' %d/%d',k,nk))

%% Saturation of the Control Inputs 
if(isempty(u_max) == 1)
    u_sat(:,k) = sign(u(:,k));
else
    sgn = sign(u(:,k));
    for cnt_u = 1 : nu
        u_sat(cnt_u,k) = sgn(cnt_u)*min(abs(u(cnt_u,k)),u_max(cnt_u));
    end % for cnt_u
end % if

%% System Behaviour
x(:,k+1) = A{vtx}*x(:,k) + B{vtx}*u_sat(:,k);

%% Quadratic Quality Criterion
cost(k,1) = get_J(x(:,1:k),u(:,1:k),Wx,Wu);

end % for k

%% Save Vertex-Results
if(exist('data','var') ~= 1)
    data = []; % Default value for DATA
end % if
data = mup_results2data(x,u,cost,vtx,data);

end % for vtx

%% Store the Obtained Results
filename = ['results_',datestr(now,30)];
save(filename,'data','-v6')

%% Plot the Obtained Results
temp = rmpc_plot(data);
