% FEAS_WAN_HUANG
%
%   Function FEAS_WAN_HUANG evaluates feasibility check of controller design
%   optimization problem.
%
%   juraj.oravec@stuba.sk
%
%


function [chk,chk_eig] = feas_wan_huang(design,model,results,setup)

t0 = toc;

% Call For Feasibility-Check Initialization
feas_init

% Initial Value of Outputs
%
chk = 0;
chk_eig = -Inf;

% Expand Structure RESULTS
%
X = results.X;
Y = results.Y;
Z = results.Z;
g = results.g;
gs = results.gs;
if(isempty(design.u_max) == 0)
	U = results.U;
end % if

% Feasibility-Check
%
ZEROx = zeros(nx,nx);
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

entity = min(eig([1, x'; x, X]));
mup_verbose(2,vbs,' FEAS_CHK: Invariant ellipsoid matrix MIN_EIG = %x.',entity)
if(entity < ZERO);
   cnt = cnt + 1;
   chk(cnt) = 1;
   chk_eig(cnt) = entity;
   mup_verbose(1,vbs,' FEAS_CHK: Invariant ellipsoid violated!')
end % if


% Nominal System 
%
% Nominal System Unconstrained - To Be Saturated
entity = min(eig([...
    X, (A{end}*X + B{end}*Y )',...
    (sqrt(Wx)*X)',...
    (sqrt(Wu)*Y)';...
    A{end}*X + B{end}*Y,...
    X,...
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
mup_verbose(2,vbs,' FEAS_CHK: VTX:UNCONSTR_NOM: Stability condition matrix MIN_EIG = %x.',entity)
if(entity < ZERO);
   cnt = cnt + 1;
   chk(cnt) = 1;
   chk_eig(cnt) = entity;
   mup_verbose(1,vbs,' FEAS_CHK: VTX:UNCONSTR_NOM: Stability condition violated!')
end % if
%
% Nominal System Constrained - To Have The Guarantee of Robust Stability
for j = 2 : nj
entity = min(eig([...
    X, (A{end}*X + B{end}*(E{j}*Y + Et{j}*Z) )',...
    (sqrt(Wx)*X)',...
    (sqrt(Wu)*(E{j}*Y + Et{j}*Z))';...
    A{end}*X + B{end}*(E{j}*Y + Et{j}*Z),...
    X,...
    ZEROx,...
    ZEROxu;...
    sqrt(Wx)*X,...
    ZEROx,...
    g*Ix,...
    ZEROxu;...
    sqrt(Wu)*(E{j}*Y + Et{j}*Z),...
    ZEROux,...
    ZEROux,...
    g*Iu...
    ]));
mup_verbose(2,vbs,' FEAS_CHK: VTX:NOM|I:%d: Stability condition matrix MIN_EIG = %x.',j,entity)
if(entity < ZERO);
   cnt = cnt + 1;
   chk(cnt) = 1;
   chk_eig(cnt) = entity;
   mup_verbose(1,vbs,' FEAS_CHK: VTX:NOM|I:%d: Stability condition violated!',j)
end % if
end % for j
%
% Uncertain Vertices
%
for v = 1 : nv
for j = 1 : nj
entity = min(eig([...
    X, (A{v}*X + B{v}*(E{j}*Y + Et{j}*Z) )';...
    A{v}*X + B{v}*(E{j}*Y + Et{j}*Z),...
    X,...
    ]));
mup_verbose(2,vbs,' FEAS_CHK: VTX:%d|I:%d: Stability condition matrix MIN_EIG = %x.',v,j,entity)
if(entity < ZERO);
   cnt = cnt + 1;
   chk(cnt) = 1;
   chk_eig(cnt) = entity;
   mup_verbose(1,vbs,' FEAS_CHK: VTX:%d|I:%d: Stability condition violated!',v,j)
end % if
end % for j
end % for v : nv

% Input Constraints
%
if(isempty(u_max) == 0)
%
% Part I
%
entity = min(eig([diag(u_max.^2), Z; Z', X ]));
mup_verbose(2,vbs,' FEAS_CHK: Input contraints matrix L2 MIN_EIG = %x.',entity)
if(entity < ZERO);
    cnt = cnt + 1;
    chk(cnt) = 1;
    chk_eig(cnt) = entity;
    mup_verbose(1,vbs,' FEAS_CHK: Input contraints matrix violated!')
end % if
%
% Part II
%
entity = min(eig([ U, Z; Z', X ]));
mup_verbose(2,vbs,' FEAS_CHK: Input contraints matrix L1 MIN_EIG = %x.',entity)
if(entity < ZERO);
    cnt = cnt + 1;
    chk(cnt) = 1;
    chk_eig(cnt) = entity;
    mup_verbose(1,vbs,' FEAS_CHK: Input contraints matrix violated!')
end % if
%
% Part III
%
entity = min([diag(U) - u_max.^2]);
mup_verbose(2,vbs,' FEAS_CHK: Input contraints matrix MIN_EIG = %x.',entity)
if(entity > ZERO);
    cnt = cnt + 1;
    chk(cnt) = 1;
    chk_eig(cnt) = entity;
    mup_verbose(1,vbs,' FEAS_CHK: Input contraints matrix violated!')
end % if
end % if

% State constraints
%
if(isempty(x_max) == 0)
for v = 1 : nv
for j = 1 : nj

entity = min(eig([
    X,...
    (A{v}*X + B{v}*(E{j}*Y + Et{j}*Z))'*C{v}';...
    C{v}*(A{v}*X + B{v}*(E{j}*Y + Et{j}*Z)),...
    diag(x_max.^2),...
    ]));

mup_verbose(2,vbs,' FEAS_CHK: VTX:%d|I:%d: State contraints matrix MIN_EIG = %x.',v,j,entity)
if(entity < ZERO);
   cnt = cnt + 1;
   chk(cnt) = 1;
   chk_eig(cnt) = entity;
   mup_verbose(1,vbs,' FEAS_CHK: VTX:%d: State contraints violated!',v)
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
end % if

end % function