% MUP_RMPCBLOCK_DEMO
%
%   M-file MUP_RMPCBLOCK_DEMO demonstrates the basic features of inline
%   robust MPC design by MUP toolbox using Simulink block RMPC_BLOCK.
%
%   juraj.oravec@stuba.sk
%



%% Controlled System
% 1st Vertex
A{1,1} = [0.93, 0.51; 0.38, 0.83];
B{1,1} = [-1.45; -0.70];
C{1,1} = [1, 0; 0, 1];
% 2nd Vertex
A{2,1} = [0.06, 0.26; 1.80, 0.87];
B{2,1} = [-1.45; -0.70];
C{2,1} = [1, 0; 0, 1];
% Nominal System
A{3,1} = [0.50, 0.39; 1.10, 0.85];
B{3,1} = [-1.45; -0.70];
C{3,1} = [1, 0; 0, 1];
% Sampling Time
Ts = 1;
%
model.A = A;
model.B = B;
model.C = C;
model.Ts = Ts;
% System Initial Conditions
x0 = [3;0];
% Steady-State Values
us = [0;0];
xs = [0;0];

%% Input and State Constraints
u_max = [10];
x_max = [10;10];

%% Cost Function Weight Matrices
Wx = eye(2);
Wu = eye(1);

%% Problem Size
nv = length(A);
nx = size(A{1},2);
nu = size(B{1},2);

%% Simulation of RMPC
mup_rmpc_scheme = mup_rmpcblock_demo_scheme;
open_system(mup_rmpc_scheme)
for vtx = 1 : nv
    sim(mup_rmpc_scheme);
    data{vtx,1}.x = data_x;
    data{vtx,1}.u = data_u;
    data{vtx,1}.cost = cost(end);
end % for vtx
global rmpc_block_ws
data{nv+1,1}.rmpc_block_ws = rmpc_block_ws;

%% Store Data
fn = ['data_',datestr(now,30),'.mat'];
save(fn,'data','-v6')

%% Show Data
figure(1), hold on, box on
figure(2), hold on, box on
t = data{1,1}.x(:,1);
figure(1),hold on,box on,xlabel('time'),ylabel('system states')
figure(2),hold on,box on,xlabel('time'),ylabel('control inputs')
for vtx = 1 : nv
    figure(1)
    x = data{vtx,1}.x(:,2:5);
    plot(t,x(:,1)+xs(1),t,x(:,2)+xs(2))
    figure(2)
    u = data{vtx,1}.u(:,2:3);
    stairs(t,u(:,1)+us(1),'r')
    stairs(t,u(:,2)+us(2),'m')
end % for vtx