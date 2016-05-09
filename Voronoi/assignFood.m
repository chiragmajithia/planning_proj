function assignFood()
	global food seg map_handle
	for i = 1:size(food)
		id = getSeg(food(i).loc)
		if(id~=0)
			seg(id).addFood([food(i).loc,i])
            food(i).s_id = id
		else
			sprintf('food(%d) in obstacle space',i)
		end
	end
	cnt = 0;
    %h = figure;
    for i = 1:size(seg)
        cnt = cnt + size(seg(i).fw_loc,1);
        sprintf('seg(%d) food alocated::',i)
        sprintf('%d,',seg(i).fw_loc)
        seg(i).initFoodMap(1);
        %figure(h);
        %imshow(seg(i).food_map');
        %figure(map_handle);
        %seg(i).visible(1);
        %input('check');
        %seg(i).visible(0);
    end
	sprintf('Total allocated food:: %d',cnt)
end

