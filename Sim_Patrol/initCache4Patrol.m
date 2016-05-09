function initCache4Patrol(n)
	global cache map_handle map squirrel1
    squirrel.task_id = squirrel.PATROL;
	%% Fill n random caches with random food
	size_x =size(map,1);
	size_y = size(map,2);
	indx = randperm(size(cache,1),n)
	patrol = figure
	for i = 1 : n
		c = cache(indx(i)).capacity;
		f_n = randi(c);
		cache(indx(i)).f_n = f_n;
		cache(indx(i)).visited();
		cache(indx(i)).patrol = true;
		loc = cache(indx(i)).loc
		dim = [0.2,i/n,0.8,0.8];
        str = strcat('Updated cache(',num2str(indx(i)), ') with food = ',num2str(f_n))
		a(i,:)= annotation('textbox',dim,'String',str,'FitBoxToText','on');
		cache(i).h.FaceColor = 'r';
	end
	input('check');
	for i = 1 : n
		a(i).Visible = 'off'
        cache(i).h.FaceColor = 'g';
	end
end