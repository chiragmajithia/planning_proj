close all;
clc;
clear;
addPaths();
initVariables;
map_fig = generateMap(seed,map_height,map_width,food_n,cache_n,obs_n);
figure(map_fig)
hold on;
initSegs;
%plotX(x_ax,y_ax);
squirrel1 = Agent;
squirrel1.spawn();
% squirrel1.path_ = [[0 0];[10,2];[20,30];[60,40];[150,90];[200,100];[250,110];[290,100]];
% squirrel1.movePath(100);
% squirrel1.setColor('g');
% squirrel1.movePath(50);
% squirrel1.path_ = flipud(Astar([seg(1).c.x,seg(1).c.y],[seg(20).c.x,seg(20).c.y],map))
% squirrel1.movePath(100);
n = size(seg,1)
curr = 1;
while true
	dest = randi([1,n]);
	if dest == curr
		continue;
	end
	squirrel1.path_ = getPath2Seg(dg,seg,curr,dest)
	squirrel1.movePath(1000);
	curr = dest;
end