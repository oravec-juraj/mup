% FEAS_CAO
%
%   Function FEAS_CAO evaluates feasibility check of controller design
%   optimization problem.
%
%   juraj.oravec@stuba.sk
%
%   est.:2013.07.17.
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

function [chk,chk_eig] = feas_cao(design,model,results,setup)

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
for j = 1 : nj
entity = min(eig([...
    X, (A{v}*X + B{v}*(E{j}*Y + Et{j}*Z) )',...
    (sqrt(Wx)*X)',...
    (sqrt(Wu)*(E{j}*Y + Et{j}*Z))';...
    A{v}*X + B{v}*(E{j}*Y + Et{j}*Z),...
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
    (A{v}*X + B{v}*Y)'*C{v}';...
    C{v}*(A{v}*X + B{v}*Y),...
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