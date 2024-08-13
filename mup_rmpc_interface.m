% MUP_RMPC_INTERFACE
%
%   Function MUP_RMPC_INTERFACE set/returns RMPC gain matrix into/from
%   block gain RMPC/RMPC_GAIN.
%
%   juraj.oravec@stuba.sk
%
%


function val = mup_rmpc_interface(rmpc_tag,block,atrib,val)

block_name = find_system('tag',rmpc_tag);
block_name = block_name{1};

if (nargin == 3) % GET VALUE
    val = get_param([block_name,'/',block],atrib);
else % SET VALUE
    set_param([block_name,'/',block],atrib,num2str(val))
end % if

end % function