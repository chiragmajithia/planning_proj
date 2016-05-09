function [ pnt ] = pointBeyoundNearestObstacle( pos_w )
global obs;
p1 = plot(pos_w(1),pos_w(2),'*')
for i = 1 : size(obs,1)
        obs_loc(i,:) = obs(i).loc;
end

pos_w = repmat(pos_w,size(obs_loc,1),1);
dist = pos_w - obs_loc;
dist = hypot(dist(:,1),dist(:,2));

[~,indx] = min(dist);

obs(indx).h.FaceColor = 'r';
pause(0.1);
obs(indx).h.FaceColor = 'b';

obs_ = obs(indx);

slope = (pos_w(2)-obs_(2))/(pos_W(1)-obs_(1));
tetha = atan(slope);
d = 10;
x = 0;
y = 0;

while(getSeg([x,y])> 0)
d = randi([10,30]);
x = d * cos(tetha) + obs_(1);
y = d * sin(tetha) + obs_(2);
p = plot(x,y,'*');
pause(0.1);
end

pnt = [x,y]
delete(p);
delete(p1);
end

