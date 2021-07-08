% MUP_RMPCBLOCK_DEMO_SCHEME
%
%   Function MUP_RMPCBLOCK_DEMO_SCHEME ensure backward compatibility with
%   MATLAB r2013b or sooner. 
%
%   mup_rmpc_scheme = mup_rmpcblock_demo_scheme
%
%   where:
%
%   mup_rmpc_scheme[class:char] - is output name of appropriate
%   MATLAB/SIMULINK scheme
%
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

function mup_rmpc_scheme = mup_rmpcblock_demo_scheme()

matlab_version = ver('MATLAB'); 
matlab_release = matlab_version.Release;
matlab_release_year = str2num(matlab_release(end-5:end-2));
if( matlab_release_year < 2014 )
    error(' ERROR: MUP_RMPC_BLOCK: Compatibility check failed! Simulink block requires MATLAB R2014a or newer!')
elseif( matlab_release_year < 2020 )
    mup_rmpc_scheme = 'mup_rmpcblock_demo_model_r2014a';
elseif( ( matlab_release_year >= 2020 ) & ( matlab_release_year <= 2020 ) )
    mup_rmpc_scheme = 'mup_rmpcblock_demo_model_r2019b';
else
    mup_rmpc_scheme = 'mup_rmpcblock_demo_model';
end % if MATLAB-version

end % function