% REFO_MAO_HUANG
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

sdp_shi
sol = optimize(constr + [xk == xkk],obj,rmpc_block_ws.setup.op);
X_opt = value(X{1});
Y_opt = value(Y{1});
if(isequal(setup.chk_feas,'on'))
    for k = 1 : N
        Xk_opt{k} = value(X{k});
        Yk_opt{k} = value(Y{k});
        Zk_opt{k} = value(Z{k});
        g_opt = value(g);
    end % for k
    %
    if(isempty(design.u_max) == 0)
        U_opt = value(U);
    end % if
    %
    for k = 1 : N+1
        for v = 1 : nv
            Qk_opt{k}{v} = value(Q{k}{v});
        end % for v
    end % for k
end % if