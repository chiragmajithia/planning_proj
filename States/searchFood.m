function [ path ] = searchFood( food_map,food_loc,v_r,itr) %food_loc is wrt to segment origin
	food_loc
    input('check food_loc');
    %Generate a gaussian filter with visual uncertainity
	p_ff = Gaussian_filter(v_r,4);
	%invert the gaussian, uncertainity at persent vertex = 0
	p_ff = max(max(p_ff)) - p_ff;
	%normalize the gaussian, uncertainity is 100% after periphery
	p_ff = (p_ff /max(max(p_ff)));

	%Generate a gaussian to add bias to the food_pos
	p_g = Gaussian_filter(15,2);
	%Generate a probabilty map of the area
	p_map = ones(size(food_map));
	%Generate a normalized map  - used for selecting indices
	n_map = p_map;
	dx = size(food_map,1)
	dy = size(food_map,2)

	filter = makeFilter(p_g,food_loc,size(p_map));

	%bias added to food locations
	p_map = filter + p_map;
	
	figure;
	surf(p_ff);
	title('uncertainity in vision');
	
	figure;
	cnt = 0;
	f_cnt = 0;

	%DEBUG variable - showing value probability at (x,y) of food in area
	food_prob = zeros(size(food_loc,1),5);
	path = [];
	while(cnt<itr)
		[r,c] = find(n_map > 0.9);
		s_r = size(r,1);
		sprintf('Number of selected indices = %d',s_r)
		i =randi([1,size(r,1)]);
		x = r(i);
		y = c(i);
		p_map = patchProb(x,y,p_map,p_ff);
		n_map = (p_map - min(min(p_map)))/(max(max(p_map))-min(min(p_map)));
		subplot(1,2,1)
		surfc(p_map);
		title('probability map');
		subplot(1,2,2)
		surf(n_map);
		title('normalized map');

		%if(food_map(x,y) > 0)
		[n,loc] = locateFood(x,y,food_loc,15)
		if(n ~= 0)
			for i = 1:n
				if(food_map(loc(i,1),loc(i,2))> 0)
					sprintf('food_found');
					f_cnt = f_cnt + 1;
					food_map(loc(i,1),loc(i,2)) = 0;
					path = [path;loc]
				end
			end
		end
		%end
		cnt = cnt + 1;
		sprintf('%d food found on %d iterations',f_cnt,cnt)
		food_prob = dispFoodProb(x,y,food_map,p_map,food_loc,food_prob);
		input('check');
	end
end

