function [ id ] = getSeg(p)
	global visual_run seg
%GETSEG Computes which segement id a given point false in
%   Detailed explanation goes here
x = p(1);
y = p(2);
n = size(seg,1);
found = false;
for i = 1 : n
	id = seg(i).id;
	o = seg(i).o
	d = seg(i).d;
	if((x >= o.x && x < o.x+d.w) && (y >= o.y && y < o.y+d.h)) 
		found = true;
		break;
	end
end
if ~found
	id = 0;
else
	if visual_run    
		p = plot(x,y,'Marker','d');
		seg(id).visible(true);
		pause(0.5)
		delete(p);
		seg(id).visible(false);
	end
end
end

