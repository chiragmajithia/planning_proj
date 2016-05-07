function [ n, loc ] = locateFood(x,y,food_loc,dist_thres )
	for i = 1:size(food_loc,1)
		p = food_loc(i,:);
		dx = x - p(1);
		dy = y - p(2);
		dist(i) = hypot(dx,dy);
	end

	[~,indx] = find(dist < dist_thres);
	n = size(indx,2);
	loc = food_loc(indx,:);
end

