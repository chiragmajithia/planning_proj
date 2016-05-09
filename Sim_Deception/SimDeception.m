indx = findPatrolCaches();
pilfered_caches = [1];

indx(pilfered_caches) = [];

c_f =  cacheFood();
c_f = c_f(indx);
c_f = c_f / max(c_f);

f_w = 1;
d_w = 5; 
t_w = 10;

squirrel1.task_id = squirrel1.DECEIVE;

deceive_bias = 0.4;

while(squirrel1.task_id == squirrel1.DECEIVE)
w = [1,deceive_bias];
d_indx = roulette(w)
pause(1)
if(d_indx(1) == 1)

dist =  distCaches([squirrel1.pos.x,squirrel1.pos.y]);
dist = dist(indx);
dist = dist/max(dist)
e_time = getElapseTime();
e_time = e_time(indx);
weights = f_w *c_f + d_w * dist + t_w * e_time;
i = roulette(weights);
pos = cache(indx(i(1))).loc;
cache(indx(i(1))).h.FaceColor = 'r';
squirrel1.temp_input = {'DECEIVE',int2str(indx(i(1)))};
squirrel1.move2Pos(cache(indx(i(1))).loc,1000);
else
%% DECEIVE CODE!

%FIND NEAREST OBSTACLE!
pos = pointBeyoundNearestObstacle([squirrel1.pos.x,squirrel1.pos.y]);
%GET SEGEMENT BEYOUND OBSTACLE



%GENERATE CACHE
handle = rectangle('Position',[pos(1),pos(2),10,10],'Curvature',[1,1],'FaceColor','r');
fake_cache = Cache;
fake_cache.initCache(-1,[pos(1),pos(2),10],handle)
squirrel1.temp_input = {'DECEIVE',int2str(-1)};
squirrel1.move2Pos(pos,1000);
delete(handle);
delete(fake_cache);

end

end