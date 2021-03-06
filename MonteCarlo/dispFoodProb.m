function food_prob =  dispFoodProb(x_,y_,map,p_map,food_loc,food_prob)
for i = 1:size(food_loc,1)
	x = food_loc(i,1);
	y = food_loc(i,2);

	if map(x,y) == 10
        if(food_prob(i,1) == 0)
		food_prob(i,1) = p_map(x,y);
		food_prob(i,[2:3]) = [x,y];
        elseif(food_prob(i,1) ~= p_map(x,y))
        food_prob(i,1) = p_map(x,y);
		food_prob(i,[2:3]) = [x_,y_];
        dist = hypot(x-x_,y-y_)
        i
        input('prob updated');
        end
        
	else
		food_prob(i,1) = 0;
		if food_prob(i,4) == 0
            sprintf('%d,4 = %d',i,food_prob(i,4))
			food_prob(i,[4:5]) = [x_,y_];
		end
	end

end
[food_prob,food_loc]
end

    % 12    43     1
    % 14    51     8
    % 14    41    16