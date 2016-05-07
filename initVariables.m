global cache_handles map cache_loc map_handle visual_run fast_run
global seg_graph;
map_width = 500;
map_height = 300;
food_n = 30;
cache_n = 10;
obs_n = 10;
seed = 1;
food(food_n) = Food;
obs(obs_n) = Obstacle;
global food;
global obs;
load('variables/constants')
fast_run = 0;
visual_run = 1;