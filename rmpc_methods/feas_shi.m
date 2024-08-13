% FEAS_SHI
%
%   Function FEAS_SHI evaluates feasibility check of controller design
%   optimization problem.
%
%   juraj.oravec@stuba.sk
%
%


function [chk,chk_eig] = feas_shi(design,model,results,setup)

t0 = toc;

% Call For Feasibility-Check Initialization
feas_init

N = design.param; % Prediction horizon N 

% Expand Structure RESULTS
%
X = results.Xk;
Y = results.Yk;
Z = results.Zk;
Q = results.Qk;
g = results.g;

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
end % for j

entity = g;  % g >= 0
mup_verbose(2,vbs,' FEAS_CHK: Inverse Lyapunov matrix weighting parameter VAL = %x.',entity)
if(entity < ZERO);
    cnt = cnt + 1;
    chk(cnt) = 1;
    chk_eig(cnt) = entity;
    mup_verbose(1,vbs,' FEAS_CHK: Inverse Lyapunov matrix weighting parameter violated!')
end % if

for k = 1 : N
    entity = min(eig(X{k}));
    mup_verbose(2,vbs,' FEAS_CHK: k:%d: Inverse Lyapunov matrix MIN_EIG = %x.',k,entity)
    if(entity <= ZERO);
        cnt = cnt + 1;
        chk(cnt) = 1;
        chk_eig(cnt) = entity;
        mup_verbose(1,vbs,' FEAS_CHK: k:%d: Inverse Lyapunov matrix violated!',k)
    end % if
end % for k

for k = 1 : N
    for v = 1 : nv
        entity = min(eig(Q{k}{v}));
        mup_verbose(2,vbs,' FEAS_CHK: VTX:%d|k:%d: Inverse PDLF matrix MIN_EIG = %x.',v,k,entity)
        if(entity < ZERO);
           cnt = cnt + 1;
           chk(cnt) = 1;
           chk_eig(cnt) = entity;
            mup_verbose(1,vbs,' FEAS_CHK: VTX:%d|k:%d: Inverse PDLF matrix violated!',v,k)
        end % if
    end % for v
end % for k

for k = 1 : N
    for v = 1 : nv
        entity = min(eig([1, x'; x, Q{k}{v}]));
        mup_verbose(2,vbs,' FEAS_CHK: VTX:%d|k:%d: Invariant ellipsoid matrix MIN_EIG = %x.',v,k,entity)
        if(entity < ZERO);
           cnt = cnt + 1;
           chk(cnt) = 1;
           chk_eig(cnt) = entity;
           mup_verbose(1,vbs,' FEAS_CHK: VTX:%d|k:%d: Invariant ellipsoid violated!',v,k)
        end % if
    end % for v
end % for k

% CASE I of II: Unconstrained Control Inputs
%
for k = 1 : N
for v = 1 : nv
for vp = 1 : nv
for j = 2 : nj
    
entity = min(eig([ X{k} + X{k}' - Q{k}{v}, (A{v}*X{k} + B{v}*(Y{k} - E{j}*Z{k}) )', (sqrt(Wx)*X{k})', (sqrt(Wu)*(Y{k} - E{j}*Z{k}))';...
    A{v}*X{k} + B{v}*(Y{k} - E{j}*Z{k}), Q{k+1}{vp}, ZEROx, ZEROxu;...
    sqrt(Wx)*X{k}, ZEROx, g*Ix, ZEROxu;...
    sqrt(Wu)*(Y{k} - E{j}*Z{k}), ZEROux, ZEROux, g*Iu] ));
mup_verbose(2,vbs,' FEAS_CHK: VTX:%d|I:%d:|k:%d: Stability condition matrix MIN_EIG = %x.',v,j,k,entity)
if(entity < ZERO);
   cnt = cnt + 1;
   chk(cnt) = 1;
   chk_eig(cnt) = entity;
   mup_verbose(1,vbs,' FEAS_CHK: VTX:%d|I:%d:|k:%d: Stability condition violated!',v,j,k)
end % if

end % for j
end % for vp : nv
end % for v : nv
end % for k : N

% CASE II of II: Constrained Control Inputs
%
for k = 1 : N
for v = 1 : nv
for vp = 1 : nv
for j = 2 : nj

entity = min(eig([...
X{k} + X{k}' - Q{k}{v},...
(A{v}*X{k} + B{v}*(Y{k} - E{j}*Z{k}) )',...
(sqrt(Wx)*X{k})',...
(sqrt(Wu)*(Y{k} - E{j}*Z{k}))';...
A{v}*X{k} + B{v}*(Y{k} - E{j}*Z{k}),...
Q{k+1}{vp},... 
ZEROx,...
ZEROxu;...
sqrt(Wx)*X{k},...
ZEROx,...
g*Ix,...
ZEROxu;...
sqrt(Wu)*(Y{k} - E{j}*Z{k}),...
ZEROux,...
ZEROux,...
g*Iu...
]));
mup_verbose(2,vbs,' FEAS_CHK: VTX:%d|VTX+:%d|I:%d|k:%d: Stability condition matrix MIN_EIG = %x.',v,vp,j,k,entity)
if(entity < ZERO);
   cnt = cnt + 1;
   chk(cnt) = 1;
   chk_eig(cnt) = entity;
   mup_verbose(1,vbs,' FEAS_CHK: VTX:%d|VTX+:%d|I:%d|k:%d: Stability condition violated!',v,vp,j,k)
end % if

end % for j
end % for vp
end % for v
end % for k

% Input Constraints
%
if(isempty(u_max) == 0)
%
% Part I
%
for k = 1 : N
for v = 1 : nv
entity = min(eig([ diag(u_max.^2), Y{k} - Z{k};...
                   (Y{k} - Z{k})', X{k} + X{k}' - Q{k}{v} ]));
mup_verbose(2,vbs,' FEAS_CHK: VTX:%d|k:%d: Input contraints matrix L2 MIN_EIG = %x.',v,k,entity)
if(entity < ZERO);
    cnt = cnt + 1;
    chk(cnt) = 1;
    chk_eig(cnt) = entity;
    mup_verbose(1,vbs,' FEAS_CHK: VTX:%d|k:%d: Input contraints matrix violated!',v,k)
end % if
end % for v
end % for k
%
% Part II
%
for k = 1 : N
for v = 1 : nv
entity = min(eig([ diag(u_max.^2), Y{k} - Z{k};...
                   (Y{k} - Z{k})', X{k} + X{k}' - Q{k}{v} ]));
mup_verbose(2,vbs,' FEAS_CHK: VTX:%d|k:%d: Input contraints matrix L1 MIN_EIG = %x.',v,k,entity)
if(entity < ZERO);
    cnt = cnt + 1;
    chk(cnt) = 1;
    chk_eig(cnt) = entity;
    mup_verbose(1,vbs,' FEAS_CHK: VTX:%d|k:%d: Input contraints matrix violated!',v,k)
end % if
end % for v
end % for k
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
for k = 1 : N
for v = 1 : nv
for j = 1 : nj

entity = min(eig([
X{k} + X{k}' - Q{k}{v},...
(C{v}*(A{v}*X{k} + B{v}*(Y{k} + E{j}*Z{k})))';...
(C{v}*(A{v}*X{k} + B{v}*(Y{k} + E{j}*Z{k}))),...
diag(x_max.^2),...
]));
mup_verbose(2,vbs,' FEAS_CHK: VTX:%d|I:%d|k:%d: State contraints matrix MIN_EIG = %x.',v,j,k,entity)
if(entity < ZERO);
   cnt = cnt + 1;
   chk(cnt) = 1;
   chk_eig(cnt) = entity;
   mup_verbose(1,vbs,' FEAS_CHK: VTX:%d|I:%d|k:%d: State contraints violated!',v,j,k)
end % if

end % for j
end % for v
end % for k
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