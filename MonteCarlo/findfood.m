p_ff = Gaussian_filter(11,4);
p_ff = max(max(p_ff)) - p_ff;
p_ff = (p_ff /max(max(p_ff)));
p_g = Gaussian_filter(15,2);
p_map = ones(size(map));
n_map = p_map;
dx = size(map,1)
dy = size(map,2)

filter = makeFilter(p_g,food_loc,size(p_map));

p_map = filter + p_map;
surf(p_map);
% input('');
figure;
surf(p_ff);
figure;
% surf(p_map);
cnt = 0;
f_cnt = 0;
food_prob = zeros(size(food_loc,1),5);
while(true)
	[r,c] = find(n_map > 0.9);
	s_r = size(r,1);
	sprintf('Number o selected indices = %d',s_r)
	i =randi([1,size(r,1)]);
	x = r(i);
	y = c(i);
	p_map = patchProb(x,y,p_map,p_ff);
	n_map = (p_map - min(min(p_map)))/(max(max(p_map))-min(min(p_map)));
	subplot(1,2,1)
	surfc(p_map);
	subplot(1,2,2)
	surf(n_map);
	[n,loc] = locateFood(x,y,food_loc,15)
	if(n ~= 0)
		for i = 1:n
			if(map(loc(i,1),loc(i,2))==10)
				sprintf('food_found');
				f_cnt = f_cnt + 1;
				map(loc(i,1),loc(i,2)) = 0;
			end
		end
	end
	cnt = cnt + 1;
	sprintf('%d food found on %d iterations',f_cnt,cnt)
	food_prob = dispFoodProb(x,y,map,p_map,food_loc,food_prob);
	input('check');
end
