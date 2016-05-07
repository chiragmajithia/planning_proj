function [ path ] = getPath2Seg(S,T )
global seg_graph seg
[dist, nodes, pred] = graphshortestpath(seg_graph, S, T);

path = [];
for i = 1:size(nodes,2)-1
   	p = seg(nodes(i)).p2n{nodes(i+1)};
	path = [path;p];
end
end

