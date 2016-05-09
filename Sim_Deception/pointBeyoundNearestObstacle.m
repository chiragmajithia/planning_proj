function [ pnt ] = pointBeyoundNearestObstacle( pos_w )
global obs;
p1 = plot(pos_w(1),pos_w(2),'*')
for i = 1 : size(obs,1)
    obs_loc(i,:) = obs(i).loc(1:2);
end

pos_w = repmat(pos_w,size(obs_loc,1),1);
dist = pos_w - obs_loc;
dist = hypot(dist(:,1),dist(:,2));

[d,indx] = min(dist);

obs(indx).h.FaceColor = 'r';
pause(1);
obs(indx).h.FaceColor = 'b';

obs_ = obs_loc(indx,:);
x0 = pos_w(1);
x1 = obs_(1);
y0 = pos_w(2);
y1 = obs_(2);

slope = (pos_w(2)-obs_(2))/(pos_w(1)-obs_(1));
tetha = atan(slope);
x = -1;
y = -1;

if (x0 > x1)
    signx = -1;
else
    signx = 1;
end

if (y0 > y1)
    signy = -1;
else
    signy = 1;
end

while(getSeg([ceil(x),ceil(y)])<= 0)
    d = rand() * 50;
    x = ceil(d * signx * cos(tetha) + obs_(1));
    y = ceil(d * signy* sin(tetha) + obs_(2));
    p = plot(x,y,'*');
    pause(1);
    delete(p);
end

pnt = [x,y];
delete(p1);
end

