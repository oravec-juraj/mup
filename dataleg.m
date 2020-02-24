function leg = dataleg(data)

nv = size(data,1);
ns = size(data{1},1);

cnt = 0;
for v = 1 : nv
    for s = 1 : ns
        cnt = cnt + 1;
        leg{cnt,1} = sprintf('v%d:s%d',v,s);
    end % for s
end % for v


end % function