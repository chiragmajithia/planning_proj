close all;
clc;
clear;
load('variables/constants')
global obs_handles food_handles cache_handles map food_loc obs_loc cache_loc mpa_handle
map = generateMap(1,300,500,30,10,10);
figure(map);
squirrel1 = Agent;
squirrel1.spawn();
squirrel1.path_ = [[10,2];[20,30];[60,40];[150,90];[200,100];[250,110];[290,100]];
squirrel1.movePath(100);
squirrel1.setColor('g');
squirrel1.movePath(50);