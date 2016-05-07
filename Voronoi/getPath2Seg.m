function [ path ] = getPath2Seg( dg,seg,S,T )
[dist, nodes, pred] = graphshortestpath(dg, S, T)

path = [];
for i = 1:size(nodes,2)-1
   	p = seg(nodes(i)).p2n{nodes(i+1)};
	path = [path;p];
end
end

