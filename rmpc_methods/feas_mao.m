% FEAS_MAO
%
%   Function FEAS_MAO evaluates feasibility check of controller design
%   optimization problem.
%
%   juraj.oravec@stuba.sk
%
%   est.:2014.08.23.
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

function [chk,chk_eig] = feas_mao(design,model,results,setup)

t0 = toc;

% Call For Feasibility-Check Initialization
feas_init

% Expand Structure RESULTS
%
X = results.X;
Y = results.Y;
g = results.g;
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

for v = 1 : nv
for vp = 1 : nv
entity = min(eig([...
X + X' - Q{v},...
X*A{v}' + Y'*B{v}',...
X*Wx^(1/2),...
Y'*Wu^(1/2);...
A{v}*X + B{v}*Y,...
Q{vp},...
ZEROx,...
ZEROxu;...
Wx^(1/2)*X,...
ZEROx,...
g*Ix,...
ZEROxu;...
Wu^(1/2)*Y,...
ZEROux,...
ZEROux,...
g*Iu,...
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
entity = min(eig([diag(u_max.^2), Y; Y', X + X' - Q{v} ]));
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
entity = min(eig([
X + X' - Q{v},...
(A{v}*X + B{v}*Y)'*C{v}';...
C{v}*(A{v}*X + B{v}*Y),...
diag(x_max.^2),...
]));
mup_verbose(2,vbs,' FEAS_CHK: VTX:%d: State contraints matrix MIN_EIG = %x.',v,entity)
if(entity < ZERO);
   cnt = cnt + 1;
   chk(cnt) = 1;
   chk_eig(cnt) = entity;
   mup_verbose(1,vbs,' FEAS_CHK: VTX:%d: State contraints violated!',v)
end % if
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