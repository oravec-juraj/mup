% GET_J
%
%   Function GET_J returnes the closed-loop control performance using the
%   LQR-based quality criterion.
%
%   J = get_J(x,u,Wx,Wu)
%
%   where;
%
%   J[class:double]  - is output value of quadratic criterion
%   x[class:double]  - is input vector of system states (column vectors)
%   u[class:double]  - is input matrix of system inputs (column vectors)
%   Wx[class:double] - is weighting matrix of system states
%   Wu[class:double] - is weighting matrix of system inputs
%
%   juraj.oravec@stuba.sk
%
%   est.:2015.06.16
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

function J = get_J(x,u,Wx,Wu)

Jx = 0;
Ju = 0;
for k = 1 : size(u,2)
    Jx(k,1) = x(:,k)'*Wx*x(:,k);
    Ju(k,1) = u(:,k)'*Wu*u(:,k);
end % for k

J = sum(Jx) + sum(Ju);

end % function
