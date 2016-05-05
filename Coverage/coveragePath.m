function [ path,temp_map ] = coveragePath( pos_s, cost_map,fh )
	%global map_handle
	center = pos_s;
	temp_map = cost_map;
	temp_map(find(cost_map==Inf)) = -1;
    temp_map(1,:) = -1;
    temp_map(:,1) = -1;
    temp_map(end,:) = -1;
    temp_map(:,end) = -1;
	path = [pos_s];

	r = center(1);
	c = center(2);
	s = size(cost_map);
	figure(fh)
    hold on;
	while temp_map(center(1),center(2)) > 0
        temp_map(path(end,1),path(end,2)) = -1;
		if(center(1) >= s(1) || center(2) >= s(2) || center(1) <= 1 || center(2) <= 1)
			continue;
		end
		m = temp_map(center(1)-1:center(1)+1,center(2)-1:center(2)+1);
		m([1,3],[1,3]) = -1;
        [r,c] = find(m == max(max(m)));
		center(1) = r(1) + center(1) -2;
		center(2) = c(1) + center(2) -2;

		path = [path;center];
		
		plot(center(2),center(1),'o');
        pause(0.001);
		
    end
    
    m
    center
end

