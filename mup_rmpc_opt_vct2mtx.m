% MUP_RMPC_OPT_VCT2MTX
%
%   Function MUP_RMPC_OPT_VCT2MTX extract matrices for controller design from OPTIMIZAR solution.
%
%   juraj.oravec@stuba.sk
%
%


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