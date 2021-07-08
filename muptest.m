% MUPTEST
%
%   Function MUPTEST evaluates the selftest.
%
%   [chk,stat] = muptest(vbs)
%
%   where:
%
%   chk[class:double] - is output flag of the selftest, such that:
%       chk == 1 - No problems detected.
%       chk == 0 - Problems detected.
%       chk == -1 - Selftest was not performed correctly.
%
%   stat[class:cell]  - is output cell-array of report information, where: 
%       stat{1} - describes overall result
%       stat{2} - describes MUP check
%       stat{3} - describes YALMIP check
%       stat{4} - describes SDP solver check
%
%   vbs[class:double] - is optional verbose-mode setup
%
%   juraj.oravec@stuba.sk
%
%   est.:2015.06.17
%   est.:2021.07.08

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

function [chk,stat] = muptest(vbs)

%% Default Verbose-mode Setup
if(nargin == 0)
    vbs = 1;
end % if

%% Initialize outputs
chk = -1;
chk_yalmip = 0;
chk_sdpsolver = 0;

%% Check list of RMPC Methods 
[rmpc_list, rmpc_kwds] = mup_get_rmpclist();
if( isempty( rmpc_list ) == 0 )
    stat{2,1} = 'RMPC design methods are available.';
    chk_mup = 1;
else
	stat{2,1} = 'RMPC design methods are unavailable!';
    chk_mup = 0;
end % if
%
%% YALMIP Check
if(exist('yalmiptest') ~= 2)
    stat{3,1} = 'YALMIP not found!';
    chk_yalmip = 0;
else
    stat{3,1} = 'YALMIP found.';
    chk_yalmip = 1;
end % if

%% SDP Solver Check
stat{4,1} = 'SDP solver(s): ';
if(exist('csdp') ~= 0)
    stat{4,1} = [stat{4}, 'CSDP,'];
    chk_sdpsolver = 1;
end
if(exist('dsdp') ~= 0)
    stat{4,1} = [stat{4}, 'DSDP,'];
    chk_sdpsolver = 1;
end
if(exist('lmilab') ~= 0)
    stat{4,1} = [stat{4}, 'LMILAB,'];
    chk_sdpsolver = 1;
end
if(exist('logdetppa') ~= 0)
    stat{4,1} = [stat{4}, 'LOGDETPPA,'];
    chk_sdpsolver = 1;
end
if(exist('mosekopt') ~= 0)
    stat{4,1} = [stat{4}, 'MOSEK,'];
    chk_sdpsolver = 1;
end
if(exist('penbmi') ~= 0)
    stat{4,1} = [stat{4}, 'PENBMI,'];
    chk_sdpsolver = 1;
end
if(exist('penlab') ~= 0)
    stat{4,1} = [stat{4}, 'PENLAB,'];
    chk_sdpsolver = 1;
end
if(exist('penlmi') ~= 0)
    stat{4,1} = [stat{4}, 'PENLMI,'];
    chk_sdpsolver = 1;
end
if(exist('scs') ~= 0)
    stat{4,1} = [stat{4}, 'SCS,'];
    chk_sdpsolver = 1;
end
if(exist('sdpam') ~= 0)
    stat{4,1} = [stat{4}, 'SDPA,'];
    chk_sdpsolver = 1;
end
if(exist('sdplr') ~= 0)
    stat{4,1} = [stat{4}, 'SDPLR,'];
    chk_sdpsolver = 1;
end
if(exist('sdpt3') ~= 0)
    stat{4,1} = [stat{4}, 'SDPT3,'];
    chk_sdpsolver = 1;
end
if(exist('sdpnal') ~= 0)
    stat{4,1} = [stat{4}, 'SDPNAL,'];
    chk_sdpsolver = 1;
end
if(exist('sedumi') ~= 0)
    stat{4,1} = [stat{4}, 'SeDuMi,'];
    chk_sdpsolver = 1;
end
if(chk_sdpsolver == 0)
    stat{4,1} = [stat{4}, 'not found '];
end % if
stat{4,1} = [stat{4}(1:end-1),'.'];

%% Soft-Constraints Module
if(exist('feas_init_soft_con') == 2)
    stat{5,1} = 'SOFT-CON module is available.';
    chk_mup = 1;
else
    stat{5,1} = 'SOFT-CON module is not available!';
    chk_mup = 0;
end % if

%% Check
if(chk_mup & chk_yalmip & chk_sdpsolver)
    chk = 1;
    stat{1,1} = 'No problems detected.';
else
    chk = 0;
    stat{1,1} = 'Problems detected!';
end % if

%% Report
mup_verbose(1,vbs,' MUPTEST finished.');
mup_verbose(1,vbs,' %s',stat{2});
disp(sprintf(' List of available methods:'))
for k = 1 : length(rmpc_list)
    mup_verbose(1,vbs,'  %2d: %s',k,rmpc_list{k});
end % for k
mup_verbose(1,vbs,' %s',stat{3});
mup_verbose(1,vbs,' %s',stat{4});
mup_verbose(1,vbs,' %s',stat{5});
mup_verbose(1,vbs,' %s',stat{1});

end % function