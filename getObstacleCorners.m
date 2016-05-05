function [ obs_corners ] = getObstacleCorners()
	global  obs_loc

	sort(obs_loc)
	[~,indx] = sort(obs_loc(:,1))
	obs_loc(:) = obs_loc(indx,:)
	for i = 1:size(obs_loc,1)
		x_c = obs_loc(i,1);
		y_c = obs_loc(i,2);
		d = obs_loc(i,3);
		obs_corners{i} = [[x_c,y_c];[x_c,y_c+d];[x_c+d,y_c];[x_c+d,y_c+d]];
		X = obs_corners{i}(:,1);
		Y = obs_corners{i}(:,2);
		%plot(X,Y,'o');
		%pause(0.5)
	end

end

