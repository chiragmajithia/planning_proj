function [map_handle] = generateMap( seed_, map_height_, map_width_, food_n_, cache_n_, obs_n_ )
	%Generate Map
	global obs_handles map food obs map_handle
	map_handle = figure;
	rectangle('Position',[0 0 map_width_ map_height_]);
	axis('equal');
	load('variables/constants')
	rng(seed_);

	map = zeros(map_width_, map_height_);

    obs(obs_n_,1) = Obstacle;
	for i = 1:obs_n_
		maxd = 40/2;
		pad = PADDING + maxd;
		x = randi([pad map_width_-pad]);
		y = randi([pad map_height_-pad]);
		d = 4*randi([5 10])/2;
		obs(i,1).loc = [x y d];
		obs(i,1).h = rectangle('Position', [x y d d], 'Curvature', [1 1], 'FaceColor', 'b');
		map(x:x+d,y:y+d) = OBS_VAL;
	end

	food(food_n_,1) = Food;
    
	for i = 1:food_n_
		x = randi([1 map_width_]);
		y = randi([1 map_height_]);
		food(i,1).loc = [x y];
		food(i,1).pick = true;
		food(i,1).h = rectangle('Position', [x y 2 2], 'Curvature', [1 1], 'FaceColor', 'r');
        food(i,1).id = i;
		map(x,y) = FOOD_VAL;
	end

	for i = 1:cache_n_
		maxd = 16;
		pad = PADDING + maxd;
		x = randi([pad map_width_-pad]);
		y = randi([pad map_height_-pad]);
		d = 4*randi([2 4]);
		cache_loc(i,:) = [x y d/2];
		cache_handle(i,:) = rectangle('Position', [x y d d], 'Curvature', [1 1], 'FaceColor', 'g');
		map(x:x+d,y:y+d) = CACHE_VAL;
	end
	initCache(cache_loc,cache_handle);
	fig = figure
	I = mat2gray(map);
	imshow(flipud(I'));
end

%{
	TODO:
		Avoid intersection of food,obstacles and caches
%}