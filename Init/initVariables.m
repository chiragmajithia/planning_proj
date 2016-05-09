global cache_handles map cache_loc map_handle visual_run fast_run 
map_width = 500;
map_height = 300;
food_n = 30;
cache_n = 10;
obs_n = 10;
seed = 1;
food(food_n,1) = Food;
cache(cache_n,1) = Cache;
obs(obs_n,1) = Obstacle;
seg(2) = Segs

load('variables/constants')
fast_run = 0;
visual_run = 1;


global food obs seg seg_graph cache