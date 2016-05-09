function [ visible,path ] = pathLoS( pos0,pos1)
	global map visual_run
    load('variables/constants');
    
    visible = true;
    path = [];
    x1 = round(pos1(1));
    x0 = round(pos0(1));
    y1 = round(pos1(2));
    y0 = round(pos0(2));

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
		path = [path;[x,y]];
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
    n = size(path,1);
    if(n>50)
    step= ceil(n/50);
    else
    step  = 2;
    end
    path = path([1:step:end,end],:);

    if(visual_run)
    line = plot(path(:,1),path(:,2),'Linewidth',4);
    pause(0.05);
    delete(line);
    end

end

