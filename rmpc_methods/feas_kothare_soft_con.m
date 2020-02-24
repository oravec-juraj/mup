% FEAS_KOTHARE_SOFT_CON
%
%   Function FEAS_KOTHARE_SOFT_CON evaluates feasibility check of
%   controller design optimization problem subject to sfoft constraints.
%
%   juraj.oravec@stuba.sk
%
%   est.:2016.03.05.
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

function [chk,chk_eig] = feas_kothare_soft_con(design,model,results,setup)

t0 = toc;

% Call For Feasibility-Check Initialization
feas_init
feas_init_soft_con

% Expand Structure RESULTS
%
X = results.X;
Y = results.Y;
g = results.g;
if(isempty(design.u_max) == 0)
	U = results.U;
end % if
if(isempty(design.param.u_sl) == 0)
	su = results.su;
end % if
if(isempty(design.param.y_sl) == 0)
	sy = results.sy;
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
entity = min(eig([...
    X,...
    X*A{v}' + Y'*B{v}',...
    X*Wx^(1/2),...
    Y'*Wu^(1/2);...
    A{v}*X + B{v}*Y,...
    X,...
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
mup_verbose(2,vbs,' FEAS_CHK: VTX:%d: Stability condition matrix MIN_EIG = %x.',v,entity)
if(entity < ZERO);
   cnt = cnt + 1;
   chk(cnt) = 1;
   chk_eig(cnt) = entity;
   mup_verbose(1,vbs,' FEAS_CHK: VTX:%d: Stability condition violated!',v)
end % if 
end % for v : nv

% Hard Input Constraints
%
if(isempty(u_max) == 0)
%
% Part I
%
entity = min(eig([diag(u_max.^2), Y; Y', X ]));
mup_verbose(2,vbs,' FEAS_CHK: Input contraints matrix L2 MIN_EIG = %x.',entity)
if(entity < ZERO);
    cnt = cnt + 1;
    chk(cnt) = 1;
    chk_eig(cnt) = entity;
    mup_verbose(1,vbs,' FEAS_CHK: Input contraints matrix violated!')
end
%
% Part II
%
entity = min(eig([ U, Y; Y', X ]));
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

% Soft input Constraints
%
if(isempty(u_sl) == 0)

entity = min(eig([ (diag(u_sl).^2 + diag(su)), Esu*Y; Y'*Esu', X ]));
mup_verbose(2,vbs,' FEAS_CHK: Input sof contraints L2-norm-matrix MIN_EIG = %x.',entity)
if(entity < ZERO);
    cnt = cnt + 1;
    chk(cnt) = 1;
    chk_eig(cnt) = entity;
    mup_verbose(1,vbs,' FEAS_CHK: Input sof  contraints failed!')
end

end % if

% Hard Output Constraints
%
if(isempty(x_max) == 0)
for v = 1 : nv
entity = min(eig([
    X,...
    (A{v}*X + B{v}*Y)'*C{v}';...
    C{v}*(A{v}*X + B{v}*Y),...
    diag(x_max.^2),...
    ]));
mup_verbose(2,vbs,' FEAS_CHK: VTX:%d: Output contraints matrix MIN_EIG = %x.',v,entity)
if(entity < ZERO);
   cnt = cnt + 1;
   chk(cnt) = 1;
   chk_eig(cnt) = entity;
   mup_verbose(1,vbs,' FEAS_CHK: VTX:%d: Output contraints violated!',v)
end % if 
end % for v
end % if

% Soft Output Constraints
%
if(isempty(y_sl) == 0)
for v = 1 : nv
entity = min(eig([
    X,...
    (A{v}*X + B{v}*Y)'*C{v}'*Esy';...
    Esy*C{v}*(A{v}*X + B{v}*Y),...
    diag(y_sl).^2 + diag(sy),...
    ]));
mup_verbose(2,vbs,' FEAS_CHK: VTX:%d: Output soft contraints matrix MIN_EIG = %x.',v,entity)
if(entity < ZERO);
   cnt = cnt + 1;
   chk(cnt) = 1;
   chk_eig(cnt) = entity;
   mup_verbose(1,vbs,' FEAS_CHK: VTX:%d: Output soft contraints failed!',v)
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
%% Soft-Constraints Warning
if((isempty(u_sl)==0)&(isempty(y_sl)==1))
    mup_verbose(1,vbs,' FEAS_CHK: Considered input soft constraints.')
elseif((isempty(u_sl)==1)&(isempty(y_sl)==0))
    mup_verbose(1,vbs,' FEAS_CHK: Considered output soft constraints.')
elseif((isempty(u_sl)==0)&(isempty(y_sl)==0))
    mup_verbose(1,vbs,' FEAS_CHK: Considered input and output soft constraints.')
else
    mup_verbose(1,vbs,' FEAS_CHK: Considered soft constraints not defined!')
end % if

%% Sumarry

if(sum(chk) > 0)
    mup_verbose(1,vbs,' FEAS_CHK: Failed! (%d infeasible constraint(s) found) (%.2f)',sum(chk),t_load)
    mup_verbose(2,vbs,' FEAS_CHK: Maximal eigenvalue: %x ',max(chk_eig))
else
    mup_verbose(1,vbs,' FEAS_CHK: Valid. (%.2f)',t_load)
end % if

end % function