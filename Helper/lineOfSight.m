function [visible, points ] = lineOfSight( x0,y0,x1,y1 )
	global map visual_run
    load('variables/constants');
    
    visible = true;
    points = [];
    x1 = round(x1);
    x0 = round(x0);
    y1 = round(y1);
    y0 = round(y0);
	dx = abs(x1 - x0);
	dy = abs(y1 - y0);
	x = x0;
	y = y0;
	n = 1 + dx + dy;
	if x1 > x0
		x_inc = 1;
	else
		x_inc = -1;
	end

	if y1>y0
		y_inc = 1;
	else
		y_inc= -1;
	end

	error = dx - dy;
	dx = dx*2;
	dy = dy*2;

	
	while n > 0
		points = [points;[x,y]];
        if(map(x,y)== OBS_VAL)
            visible = false;
            break;
        end
		if error >= 0
			x = x+ x_inc;
			error = error - dy;
		else
			y = y + y_inc;
			error = error + dx;
		end
		n= n-1;
    end
    if(visual_run)
    line = plot(points(:,1),points(:,2),'Linewidth',4);
    pause(0.05)
    delete(line);
    end
end

