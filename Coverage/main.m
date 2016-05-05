
clear;
close all;

map_height = 500;
map_width = 500;
n_obs = 10;
n_food = 0;
n_cache = 0;


addpath(getRelPath(1));
global obs_handles food_handles cache_handles map food_loc obs_loc cache_loc map_handle

%addpath(strcat(getRelPath(1),'/variables/constants'));
map_handle = generateMap(1,map_height,map_width,n_food,n_cache,n_obs);
rng(20);
start_pos.x = randi([1 map_width]);
start_pos.y = randi([1 map_height]);

goal_pos.x = randi([1 map_width]);
goal_pos.y = randi([1 map_height]);

figure(map_handle);
hold on;
plot([start_pos.x goal_pos.x],[start_pos.y goal_pos.y]);
start_pos
goal_pos

pos_s = [start_pos.x,start_pos.y];
pos_g = [goal_pos.x,goal_pos.y];

cost_map = waveCostMap(map, pos_s, pos_g);
max_cost = max(max(cost_map));
temp_map(find(cost_map==Inf)) = max([map_height,map_width]);
fh = figure;
I = mat2gray(cost_map);
imshow(I);

[path,temp_map] = coveragePath(pos_s,cost_map,fh);

