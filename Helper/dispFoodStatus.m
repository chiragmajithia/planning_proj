function  dispFoodStatus()
global food;
picked = [];
unpicked = [];
for i = 1:size(food,1)
	if(food(i).pick == false)
		picked = [picked,i];
	else
		unpicked = [unpicked,i]
	end
end
picked
unpicked
end

