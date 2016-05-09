function [ food_map,food_loc ] = genFoodMap( indx, v_r )
	global seg
	figure;
	food_map = zeros(seg(indx).d.w,seg(indx).d.h);
	o = seg(indx).o
	food_loc = seg(indx).f_loc
	food_loc = [(food_loc(:,1)-o.x),(food_loc(:,2)-o.y),(food_loc(:,3))]

	for i = 1: size(food_loc,1)
        sprintf('food_loc %d,%d',food_loc(i,1),food_loc(i,2))
		food_map = patchCircle(v_r,food_loc(i,1),food_loc(i,2),food_loc(i,3),food_map);
        imshow(food_map',[0,1]);
        food_loc(i,3)
        input('check')
    end
    max(max(food_map))
end
