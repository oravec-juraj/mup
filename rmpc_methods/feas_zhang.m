% FEAS_ZHANG
%
%   Function FEAS_ZHANG evaluates feasibility check of controller design
%   optimization problem.
%
%   juraj.oravec@stuba.sk
%
%


function [chk,chk_eig] = feas_zhang(design,model,results,setup)

t0 = toc;

% Call For Feasibility-Check Initialization
feas_init

% Expand Structure RESULTS
%
Q = results.Q;
W = results.W;
Y = results.Y;
Z = results.Z;
g = results.g;
X = results.X;
if(isempty(design.u_max) == 0)
	U = results.U;
end % if

% Feasibility-Check
%
ZEROx = zeros(nx,nx);
ZEROu = zeros(nu,nu);
ZEROux = zeros(nu,nx);
ZEROxu = zeros(nx,nu);
Ix = eye(nx);
Iu = eye(nu);
%
[u_var,nj] = get_variat(nu);
for j = 1 : nj
    E{j,1} = diag(u_var(:,nj + 1 - j));
    Et{j,1} = diag(u_var(:,j));
end % for j

entity = min(eig(X));
mup_verbose(2,vbs,' FEAS_CHK: Inverse Lyapunov matrix MIN_EIG = %x.',entity)
if(entity < ZERO);
    cnt = cnt + 1;
    chk(cnt) = 1;
    chk_eig(cnt) = entity;
    mup_verbose(1,vbs,' FEAS_CHK: Inverse Lyapunov matrix violated!')
end % if

for j = 1 : nj
entity = min(eig(W{j}));
mup_verbose(2,vbs,' FEAS_CHK: I:%d: Inverse SDLF matrix W MIN_EIG = %x.',j,entity)
if(entity < ZERO);
   cnt = cnt + 1;
   chk(cnt) = 1;
   chk_eig(cnt) = entity;
    mup_verbose(1,vbs,' FEAS_CHK: I:%d: Inverse SDLF W matrix violated!',j)
end % if
end % for j

for j = 1 : nj
entity = min(eig(Q{j}));
mup_verbose(2,vbs,' FEAS_CHK: I:%d: Inverse SDLF matrix Q MIN_EIG = %x.',j,entity)
if(entity < ZERO);
   cnt = cnt + 1;
   chk(cnt) = 1;
   chk_eig(cnt) = entity;
    mup_verbose(1,vbs,' FEAS_CHK: I:%d: Inverse SDLF Q matrix violated!',j)
end % if
end % for j

for j = 1 : nj
entity = min(eig([1, x'; x, X + X' - W{j}]));
mup_verbose(2,vbs,' FEAS_CHK: I:%d: Invariant ellipsoid matrix MIN_EIG = %x.',j,entity)
if(entity < ZERO);
   cnt = cnt + 1;
   chk(cnt) = 1;
   chk_eig(cnt) = entity;
   mup_verbose(1,vbs,' FEAS_CHK: I:%d: Invariant ellipsoid violated!',j)
end % if
end % for j
    
for v = 1 : nv
for j = 1 : nj
for jp = 1 : nj

entity = min(eig([...
X + X' - Q{jp},...
X*A{v}' + (E{j}*Y + Et{j}*Z)'*B{v}',...
X*Wx^(1/2),...
(E{j}*Y + Et{j}*Z)'*Wu^(1/2);...
A{v}*X + B{v}*(E{j}*Y + Et{j}*Z),...
W{j},...
ZEROx,...
ZEROxu;...
Wx^(1/2)*X,...
ZEROx,...
g*Ix,...
ZEROxu;...
Wu^(1/2)*(E{j}*Y + Et{j}*Z),...
ZEROux,...
ZEROux,...
g*Iu,...
]));
mup_verbose(2,vbs,' FEAS_CHK: VTX:%d|I:%d|I+:%d: Stability condition matrix MIN_EIG = %x.',v,j,jp,entity)
if(entity < ZERO);
   cnt = cnt + 1;
   chk(cnt) = 1;
   chk_eig(cnt) = entity;
   mup_verbose(1,vbs,' FEAS_CHK: VTX:%d|I:%d|I+:%d: Stability condition violated!',v,j,jp)
end % if

end % for jp
end % for j
end % for v

% Input Constraints
%
if(isempty(u_max) == 0)
%
% Part I
%
for j = 1 : nj
entity = min(eig([diag(u_max.^2), Z; Z', W{j} ]));
mup_verbose(2,vbs,' FEAS_CHK: I:%d: Input contraints matrix L2 MIN_EIG = %x.',j,entity)
if(entity < ZERO);
    cnt = cnt + 1;
    chk(cnt) = 1;
    chk_eig(cnt) = entity;
    mup_verbose(1,vbs,' FEAS_CHK: I:%d: Input contraints matrix violated!',j)
end % if
end % for j
%
% Part II
%
for j = 1 : nj
entity = min(eig([ U, Z; Z', W{j} ]));
mup_verbose(2,vbs,' FEAS_CHK: I:%d: Input contraints matrix L1 MIN_EIG = %x.',j,entity)
if(entity < ZERO);
    cnt = cnt + 1;
    chk(cnt) = 1;
    chk_eig(cnt) = entity;
    mup_verbose(1,vbs,' FEAS_CHK: I:%d: Input contraints matrix violated!',j)
end % if
end % for j
%
% Part III
%
for j = 1 : nj
entity = min([diag(U) - u_max.^2]); 
mup_verbose(2,vbs,' FEAS_CHK: I:%d: Input contraints matrix MIN_EIG = %x.',j,entity)
if(entity > ZERO);
    cnt = cnt + 1;
    chk(cnt) = 1;
    chk_eig(cnt) = entity;
    mup_verbose(1,vbs,' FEAS_CHK: I:%d: Input contraints matrix violated!',j)
end % if
end % for j
end % if

% State constraints
%
if(isempty(x_max) == 0)
for v = 1 : nv
for j = 1 : nj
entity = min(eig([
X + X' - W{j},...
(A{v}*X + B{v}*(E{j}*Y + Et{j}*Z))'*C{v}';...
C{v}*(A{v}*X + B{v}*(E{j}*Y + Et{j}*Z)),...
diag(x_max.^2),...
]));
mup_verbose(2,vbs,' FEAS_CHK: VTX:%d|I:%d: State contraints matrix MIN_EIG = %x.',v,j,entity)
if(entity < ZERO);
   cnt = cnt + 1;
   chk(cnt) = 1;
   chk_eig(cnt) = entity;
   mup_verbose(1,vbs,' FEAS_CHK: VTX:%d|I:%d: State contraints violated!',v,j)
end % if
end % for v
end % for j
end % if

% --------------------------------------------------- %
%
% Feasibility Check - Summary
%
% --------------------------------------------------- %
%
t_load2 = toc;
t_load = t_load2 - t0;
%
if(sum(chk) > 0)
    mup_verbose(1,vbs,' FEAS_CHK: Failed! (%d infeasible constraint(s) found) (%.2f)',sum(chk),t_load)
    mup_verbose(2,vbs,' FEAS_CHK: Maximal eigenvalue: %x ',max(chk_eig))
else
    mup_verbose(1,vbs,' FEAS_CHK: Valid. (%.2f)',t_load)
end

end % function