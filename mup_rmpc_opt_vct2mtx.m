% MUP_RMPC_OPT_VCT2MTX
%
%   Function MUP_RMPC_OPT_VCT2MTX extract matrices for controller design from OPTIMIZAR solution.
%
%   juraj.oravec@stuba.sk
%
%   est.:2013.07.17.
%   rev.:2013.12.05.
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

function [X,Y,U,g,varargout] = mup_rmpc_opt_vct2mtx(vct,nx,nu)

% Number of rows
%
nr = nx + nu + 1;

% Number of columns
%
nc = nx + nu;

% Restore Matrix from Vector
%
for c = 1 : nc
    mtx(:,c) = vct( (c-1)*nr + 1 : c*nr);
end % for c

% X
%
X = mtx(1:nx, 1:nx);

% Y
%
Y = mtx(nx+1:nx+nu, 1:nx);

% U
%
U = mtx(nx+1:nx+nu, nx+1:nx+nu);

% g
%
g = mtx(nx+nu+1, 1);

if(nargout == 5)
    %
    % Expand PDLF-matrix Q{v}
    %
    vctw = vct(nr*nc + 1:end);
    nv = length(vctw)/(nr*nx);
    ncw = nx*nv;
    for c = 1 : ncw
        mtxw(:,c) = vctw( (c-1)*nr + 1 : c*nr);
    end % for c
    for v = 1 : nv
        Q{v,1} = mtxw(1:nx, (v-1)*nx+1: v*nx );
    end % for v
    varargout{1} = Q;
end % if

end % function