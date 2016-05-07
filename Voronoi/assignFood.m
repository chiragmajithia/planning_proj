function assignFood()
	global food seg
	for i = 1:size(food)
		id = getSeg(food(i).loc)
		if(id~=0)
			seg(id).f_loc = [food(i).loc,i]
		else
			sprintf('food(%d) in obstacle space',i)
		end
	end
end

