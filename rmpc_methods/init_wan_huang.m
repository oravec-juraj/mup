% INIT_WAN_HUANG
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

mtx_opt = vct2mtx(vct_opt,row,col);
X_opt = mtx_opt{1};
Y_opt = mtx_opt{2};
%
if(isequal(setup.chk_feas,'on'))
    Z_opt = mtx_opt{3};
    g_opt = mtx_opt{4};
    gs_opt = mtx_opt{5};
    %
    if(isempty(design.u_max) == 0)
        U_opt = mtx_opt{6};
    end % if
end % if
