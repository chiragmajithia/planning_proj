function food_loc = dropfood( n )

global map;
dx = size(map,1);
dy = size(map,2);

cnt = 1;
while cnt < n;
	x = randi([1,dx]);
	y = randi([1,dy]);
	food_loc(cnt,:) = [x,y];
	map(x,y) = 10;
	cnt = cnt+1;
end

end

