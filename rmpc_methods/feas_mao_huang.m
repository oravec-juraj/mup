% FEAS_MAO_HUANG
%
%   Function FEAS_MAO_HUANG evaluates feasibility check of controller design
%   optimization problem.
%
%   juraj.oravec@stuba.sk
%
%


function [chk,chk_eig] = feas_mao_huang(design,model,results,setup)

t0 = toc;

% Call For Feasibility-Check Initialization
feas_init

% Expand Structure RESULTS
%
X = results.X;
Y = results.Y;
Z = results.Z;
g = results.g;
gs = results.gs;
Q = results.Q;

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

entity = [g - gs];  % g - gs > 0
mup_verbose(2,vbs,' FEAS_CHK: Inverse Lyapunov matrix weighting parameter VAL = %x.',entity)
if(entity < ZERO);
    cnt = cnt + 1;
    chk(cnt) = 1;
    chk_eig(cnt) = entity;
    mup_verbose(1,vbs,' FEAS_CHK: Inverse Lyapunov matrix weighting parameter violated!')
end % if

entity = min(eig(X));
mup_verbose(2,vbs,' FEAS_CHK: Inverse Lyapunov matrix MIN_EIG = %x.',entity)
if(entity < ZERO);
    cnt = cnt + 1;
    chk(cnt) = 1;
    chk_eig(cnt) = entity;
    mup_verbose(1,vbs,' FEAS_CHK: Inverse Lyapunov matrix violated!')
end % if

for v = 1 : nv
entity = min(eig(Q{v}));
mup_verbose(2,vbs,' FEAS_CHK: VTX:%d: Inverse PDLF matrix MIN_EIG = %x.',v,entity)
if(entity < ZERO);
   cnt = cnt + 1;
   chk(cnt) = 1;
   chk_eig(cnt) = entity;
    mup_verbose(1,vbs,' FEAS_CHK: VTX:%d: Inverse PDLF matrix violated!',v)
end % if
end % for v

for v = 1 : nv
entity = min(eig([1, x'; x, Q{v}]));
mup_verbose(2,vbs,' FEAS_CHK: VTX:%d: Invariant ellipsoid matrix MIN_EIG = %x.',v,entity)
if(entity < ZERO);
   cnt = cnt + 1;
   chk(cnt) = 1;
   chk_eig(cnt) = entity;
   mup_verbose(1,vbs,' FEAS_CHK: VTX:%d: Invariant ellipsoid violated!',v)
end % if
end % for v

% CASE I of II: Unconstrained Control Inputs
%
for v = 1 : nv
for vp = 1 : nv
for j = 2 : nj

entity = min(eig([...
X + X' - Q{v},...
(A{v}*X + B{v}*Y)',...
(sqrt(Wx)*X)',...
(sqrt(Wu)*Y)';...
A{v}*X + B{v}*Y,...
Q{vp},...
ZEROx,...
ZEROxu;...
sqrt(Wx)*X,...
ZEROx,...
gs*Ix,...
ZEROxu;...
sqrt(Wu)*Y,...
ZEROux,...
ZEROux,...
gs*Iu...
    ]));
mup_verbose(2,vbs,' FEAS_CHK: VTX:%d|I:%d: Stability condition matrix MIN_EIG = %x.',v,j,entity)
if(entity < ZERO);
   cnt = cnt + 1;
   chk(cnt) = 1;
   chk_eig(cnt) = entity;
   mup_verbose(1,vbs,' FEAS_CHK: VTX:%d|I:%d: Stability condition violated!',v,j)
end % if

end % for j
end % for vp : nv
end % for v : nv

% CASE II of II: Constrained Control Inputs
%
for v = 1 : nv
for vp = 1 : nv
for j = 2 : nj

entity = min(eig([...
X + X' - Q{v},...
X*A{v}' + (E{j}*Y + Et{j}*Z)'*B{v}',...
X*Wx^(1/2),...
Z'*Wu^(1/2);...
A{v}*X + B{v}*(E{j}*Y + Et{j}*Z),...
Q{vp},...
ZEROx,...
ZEROxu;...
Wx^(1/2)*X,...
ZEROx,...
g*Ix,...
ZEROxu;...
Wu^(1/2)*Z,...
ZEROux,...
ZEROux,...
g*Iu,...
   ]));
mup_verbose(2,vbs,' FEAS_CHK: VTX:%d|VTX+:%d|I:%d: Stability condition matrix MIN_EIG = %x.',v,vp,j,entity)
if(entity < ZERO);
   cnt = cnt + 1;
   chk(cnt) = 1;
   chk_eig(cnt) = entity;
   mup_verbose(1,vbs,' FEAS_CHK: VTX:%d|VTX+:%d|I:%d: Stability condition violated!',v,vp,j)
end % if

end % for j
end % for vp
end % for v

% Input Constraints
%
if(isempty(u_max) == 0)
%
% Part I
%
for v = 1 : nv
entity = min(eig([diag(u_max.^2), Z; Z', X + X' - Q{v} ]));
mup_verbose(2,vbs,' FEAS_CHK: VTX:%d: Input contraints matrix L2 MIN_EIG = %x.',v,entity)
if(entity < ZERO);
    cnt = cnt + 1;
    chk(cnt) = 1;
    chk_eig(cnt) = entity;
    mup_verbose(1,vbs,' FEAS_CHK: VTX:%d: Input contraints matrix violated!',v)
end % if
end % for v
%
% Part II
%
for v = 1 : nv
entity = min(eig([ U, Y; Y', X + X' - Q{v} ]));
mup_verbose(2,vbs,' FEAS_CHK: VTX:%d: Input contraints matrix L1 MIN_EIG = %x.',v,entity)
if(entity < ZERO);
    cnt = cnt + 1;
    chk(cnt) = 1;
    chk_eig(cnt) = entity;
    mup_verbose(1,vbs,' FEAS_CHK: VTX:%d: Input contraints matrix violated!',v)
end % if
end % for v
%
% Part III
%
for v = 1 : nv
entity = min([diag(U) - u_max.^2]); 
mup_verbose(2,vbs,' FEAS_CHK: VTX:%d: Input contraints matrix MIN_EIG = %x.',v,entity)
if(entity > ZERO);
    cnt = cnt + 1;
    chk(cnt) = 1;
    chk_eig(cnt) = entity;
    mup_verbose(1,vbs,' FEAS_CHK: VTX:%d: Input contraints matrix violated!',v)
end % if
end % for v
end % if

% State constraints
%
if(isempty(x_max) == 0)
for v = 1 : nv
for j = 1 : nj

entity = min(eig([
X + X' - Q{v},...
(C{v}*(A{v}*X + B{v}*(E{j}*Y + Et{j}*Z)))';...
(C{v}*(A{v}*X + B{v}*(E{j}*Y + Et{j}*Z))),...
diag(x_max.^2),...
]));
mup_verbose(2,vbs,' FEAS_CHK: VTX:%d|I:%d: State contraints matrix MIN_EIG = %x.',v,j,entity)
if(entity < ZERO);
   cnt = cnt + 1;
   chk(cnt) = 1;
   chk_eig(cnt) = entity;
   mup_verbose(1,vbs,' FEAS_CHK: VTX:%d|I:%d: State contraints violated!',v,j)
end % if

end % for j

end % for v
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