function [ cost_map ] = waveCostMap(map,pos_s,pos_g)
cost_map = ones(size(map))*-1;
cost_map(find(map==100)) = Inf;

ind = list();
ind.append(pos_g)
cost_map(pos_g(1),pos_g(2)) = 0;
while ~isempty(ind.arr)
	c =ind.popFirst();
	[n,cost_map] = updateNeighbors(c,cost_map);
	ind.cat(n);
    c;
    size(n);
	%input('check');
end
end
