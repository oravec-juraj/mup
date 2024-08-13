% FEAS_LI
%
%   Function FEAS_LI evaluates feasibility check of controller design
%   optimization problem.
%
%   juraj.oravec@stuba.sk
%
%


function [chk,chk_eig] = feas_li(design,model,results,setup)

t0 = toc;

% Call For Feasibility-Check Initialization
feas_init

% Expand Structure RESULTS
%
Y = results.Y;
g = results.g;
X = results.X;
Yp = results.Yp;
if(isempty(design.u_max) == 0)
	U = results.U;
    Up = results.Up;
end % if

% Feasibility-Check
%
ZEROx = zeros(nx,nx);
ZEROu = zeros(nu,nu);
ZEROux = zeros(nu,nx);
ZEROxu = zeros(nx,nu);
Ix = eye(nx);
Iu = eye(nu);

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


for v = 1 : nv
for vp = 1 : nv
entity = min(eig([...
    X,...
    (A{vp}*(A{v}*X + B{v}*Y) + B{vp}*Yp{v})',...
    (Wx^(1/2)*X)',...
    (Wu^(1/2)*Y)',...
    (Wx^(1/2)*(A{v}*X + B{v}*Y))',...
    (Wu^(1/2)*Yp{v})';... % End of Row No.1
    A{vp}*(A{v}*X + B{v}*Y) + B{vp}*Yp{v},...
    X,...
    ZEROx,...
    ZEROxu,...
    ZEROx,...
    ZEROxu;... % End of Row No.2
    Wx^(1/2)*X,...
    ZEROxu,...
    g*Ix,...
    ZEROx,...
    ZEROx,...
    ZEROxu;... % End of Row No.3
    Wu^(1/2)*Y,...
    ZEROu,...
    ZEROux,...
    g*Iu,...
    ZEROux,...
    ZEROux;... % End of Row No.4
    Wx^(1/2)*(A{v}*X + B{v}*Y),...
    ZEROxu,...
    ZEROx,...
    ZEROx,...
    g*Ix,...
    ZEROxu;... % End of Row No.5
    Wu^(1/2)*Yp{v},...
    ZEROu,...
    ZEROux,...
    ZEROux,...
    ZEROux,...
    g*Iu;... % End of Row No.6
    ]));
mup_verbose(2,vbs,' FEAS_CHK: VTX:%d|VTX+:%d: Stability condition matrix MIN_EIG = %x.',v,vp,entity)
if(entity < ZERO);
   cnt = cnt + 1;
   chk(cnt) = 1;
   chk_eig(cnt) = entity;
   mup_verbose(1,vbs,' FEAS_CHK: VTX:%d|VTX+:%d: Stability condition violated!',v,vp)
end % if
end % for vp
end % for v

% Input Constraints
%
if(isempty(u_max) == 0)
%
% Part I
%
for v = 1 : nv
entity = min(eig([ U, Y; Y', X ]));
mup_verbose(2,vbs,' FEAS_CHK: VTX:%d: Input contraints matrix L1 MIN_EIG = %x.',v,entity)
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
entity = min([diag(U) - u_max.^2]); 
mup_verbose(2,vbs,' FEAS_CHK: VTX:%d: Input contraints matrix MIN_EIG = %x.',v,entity)
if(entity > ZERO);
    cnt = cnt + 1;
    chk(cnt) = 1;
    chk_eig(cnt) = entity;
    mup_verbose(1,vbs,' FEAS_CHK: VTX:%d: Input contraints matrix violated!',v)
end % if
end % for v
%
% One-Step Ahead
%
for v = 1 : nv
entity = min(eig([ Up{v}, Yp{v};...
Yp{v}', X]));
mup_verbose(2,vbs,' FEAS_CHK: VTX+:%d: Input contraints matrix MIN_EIG = %x.',v,entity)
if(entity < ZERO);
   cnt = cnt + 1;
   chk(cnt) = 1;
   chk_eig(cnt) = entity;
   mup_verbose(1,vbs,' FEAS_CHK: VTX+:%d: Input contraints violated!',v)
end % if
end % for v
%
for v = 1 : nv
entity = min([diag(Up{v}) - u_max.^2]); 
mup_verbose(2,vbs,' FEAS_CHK: VTX+:%d: Input contraints matrix MIN_EIG = %x.',v,entity)
if(entity > ZERO);
    cnt = cnt + 1;
    chk(cnt) = 1;
    chk_eig(cnt) = entity;
    mup_verbose(1,vbs,' FEAS_CHK: VTX+:%d: Input contraints matrix violated!',v)
end % if
end % for v

% State constraints
%
if(isempty(x_max) == 0)
%
% Part I
%
for v = 1 : nv
entity = min(eig([...
diag(x_max.^2),...
(A{v}*X + B{v}*Y);...
(A{v}*X + B{v}*Y)',...
X ]));
mup_verbose(2,vbs,' FEAS_CHK: VTX:%d: State contraints matrix MIN_EIG = %x.',v,entity)
if(entity < ZERO);
   cnt = cnt + 1;
   chk(cnt) = 1;
   chk_eig(cnt) = entity;
   mup_verbose(1,vbs,' FEAS_CHK: VTX:%d: State contraints violated!',v)
end % if
end % for v
%
% One-Step Ahead
%
for v = 1 : nv
for vp = 1 : nv
entity = min(eig([...
diag(x_max.^2),...
C{vp}*(A{vp}*(A{v}*X + B{v}*Y) + B{vp}*Yp{v});...
(C{vp}*(A{vp}*(A{v}*X + B{v}*Y) + B{vp}*Yp{v}))',...
X ]));
mup_verbose(2,vbs,' FEAS_CHK: VTX:%d|VTX+:%d: State contraints matrix MIN_EIG = %x.',v,vp,entity)
if(entity < ZERO);
   cnt = cnt + 1;
   chk(cnt) = 1;
   chk_eig(cnt) = entity;
   mup_verbose(1,vbs,' FEAS_CHK: VTX:%d|VTX+:%d: State contraints violated!',v,vp)
end % if
end % for vp
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