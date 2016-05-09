indx = findPatrolCaches();
c_f =  cacheFood();
c_f = c_f(indx);
c_f = c_f / max(c_f);

f_w = 1;
d_w = 5; 
t_w = 10;

squirrel1.task_id = squirrel1.PATROL;

while(squirrel1.task_id == squirrel1.PATROL)
dist =  distCaches([squirrel1.pos.x,squirrel1.pos.y]);
dist = dist(indx);
dist = dist/max(dist)
e_time = getElapseTime();
e_time = e_time(indx);
weights = f_w *c_f + d_w * dist + t_w * e_time;
i = roulette(weights);
pos = cache(indx(i(1))).loc;
cache(indx(i(1))).h.FaceColor = 'r';
squirrel1.temp_input = {'PATROL',int2str(indx(i))};
squirrel1.move2Pos(cache(indx(i(1))).loc,1000);
end