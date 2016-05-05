close all;
clc;
clear;
global obs_handles food_handles cache_handles map food_loc obs_loc cache_loc map_handle segs seg_handle

load('variables/constants')
map_width = 500;
map_height = 300;
food_n = 30;
cache_n = 10;
obs_n = 10;
seed = 1;
map_fig = generateMap(seed,map_height,map_width,food_n,cache_n,obs_n);
figure(map_fig)
hold on;
[x_ax,y_ax] = generateLines();
segs=generateSegs(x_ax,y_ax);
%plotX(x_ax,y_ax);
squirrel1 = Agent;
squirrel1.spawn();
squirrel1.path_ = [[0 0];[10,2];[20,30];[60,40];[150,90];[200,100];[250,110];[290,100]];
squirrel1.movePath(100);
squirrel1.setColor('g');
squirrel1.movePath(50);