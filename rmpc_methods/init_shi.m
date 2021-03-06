% INIT_SHI
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
    g_opt = mtx_opt{3};
    %
    if(isempty(design.u_max) == 0)
        U_opt = mtx_opt{4};
        temp_cnt = 4; % 1 => X, 2 => Y, 3 => g, 4 => U
    else
        temp_cnt = 3; % 1 => X, 2 => Y, 3 => Z
    end % if
    %
    for t = 1 : N % Prediction horizon N (from PARAM)
        temp_cnt = temp_cnt + 1;
        Xk_opt{t} = mtx_opt{temp_cnt};
        temp_cnt = temp_cnt + 1;
        Yk_opt{t} = mtx_opt{temp_cnt};
        temp_cnt = temp_cnt + 1;
        Zk_opt{t} = mtx_opt{temp_cnt};
    end % for k
    %
    for t = 1 : N+1 % Prediction horizon N (from PARAM)
        for v = 1 : problem.nv; 
            temp_cnt = temp_cnt + 1;
            Qk_opt{t}{v} = mtx_opt{temp_cnt};
        end % for v
    end % for k
    %
    clear temp_cnt;
end % if
