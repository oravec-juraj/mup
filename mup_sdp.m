% mup_sdp
%
%   M-file MUP_SDP formulates the selected optimization problem in the form
%   of semidefinite programming (SDP) to evaluate the selected robust MPC
%   design method. This script calls m-file SDP_$RMPC_METHOD.
%
%   juraj.oravec@stuba.sk
%
%   est.:2015.06.16

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

%% Initialize RMPC Design Structures
mup_init_design

%% Expand structure PROBLEM
nv = problem.nv;
nx = problem.nx;
nu = problem.nu;

%% Formulate Command
cmd = ['sdp_',design.rmpc_kwd];

%% Check Command
if(exist(cmd) == 2)
    
    %% Evaluate Command
    eval(cmd)
    
else

    %% Error
    mup_verbose(0,1,' MUP:ERROR: File "%s" not found!',cmd)

end % if