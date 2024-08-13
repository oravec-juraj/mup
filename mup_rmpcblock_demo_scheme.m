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
%


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