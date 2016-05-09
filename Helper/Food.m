classdef Food<handle
    %FOOD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    id
    loc
    pick
    h
    c_id
    s_id
    end
    
    methods
    
    function initFood(obj,id,food_arr,handle)
		obj.loc(1) = food_arr(1);
		obj.loc(2) = food_arr(2);
        obj.id =id;
		obj.picked = false;
		obj.h = handle;
	end
    
    end
    
end

