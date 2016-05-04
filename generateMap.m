function [map_handle] = generateMap( seed_, map_height_, map_width_, food_n_, cache_n_, obstacle_n_ )
	%Generate Map
	global obs_handles food_handles cache_handles map food_loc obs_loc cache_loc map_handle
	map_handle = figure;
	rectangle('Position',[0 0 map_width_ map_height_]);
	axis('equal');
	load('variables/constants')
	rng(seed_);

	map = zeros(map_width_, map_height_);

	for i = 1:obstacle_n_
		x = randi([20 map_width_-20]);
		y = randi([20 map_height_-20]);
		d = 4*randi([5 10]);
		obst_loc(i,:) = [x y d/2];
		obst_handle(i) = rectangle('Position', [x y d d], 'Curvature', [1 1], 'FaceColor', 'b');
		map(x-d/2:x+d/2,y-d/2:y+d/2) = OBS_VAL;
	end

	for i = 1:food_n_
		x = randi([1 map_width_]);
		y = randi([1 map_height_]);
		food_loc(i,:) = [x y];
		food_handle(i) = rectangle('Position', [x y 2 2], 'Curvature', [1 1], 'FaceColor', 'r');
		map(x,y) = FOOD_VAL;
	end

	for i = 1:cache_n_
		x = randi([20 map_width_-20]);
		y = randi([20 map_height_-20]);
		d = 4*randi([2 4]);
		cache_loc(i,:) = [x y d/2];
		cache_loc(i) = rectangle('Position', [x y d d], 'Curvature', [1 1], 'FaceColor', 'b');
		map(x-d/2:x+d/2,y-d/2:y+d/2) = CACHE_VAL;
	end

	fig = figure
	I = mat2gray(map);
	imshow(I);
end

%{
	TODO:
		Avoid intersection of food,obstacles and caches
%}