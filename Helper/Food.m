classdef Food<handle
    %FOOD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    loc
    pick
    h
    end
    
    methods
    
    function initFood(obj,food_arr,handle)
		obj.loc(1) = food_arr(1);
		obj.loc(2) = food_arr(2);
		obj.picked = false;
		obj.h = handle;
	end
    
    end
    
end

