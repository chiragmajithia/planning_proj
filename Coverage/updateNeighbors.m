function [ n,cost_map ] = updateNeighbors( pos,cost_map )
    s = size(cost_map);
    if(pos(1) >= s(1) || pos(2) >= s(2) || pos(1) <= 1 || pos(2) <= 1)
        n = [];
        return;
    end
    
	center = pos;
	m = cost_map(center(1)-1:center(1)+1,center(2)-1:center(2)+1);
	cost = cost_map(center(1),center(2));
	[r,c]= find(m == -1);
	n = [];
	for i = 1:size(r)
		n_(1) = r(i) + center(1) -2;
		n_(2) = c(i) + center(2) -2;
		n = [n;n_];
		cost_map(n_(1),n_(2)) = cost+1;
	end
end

