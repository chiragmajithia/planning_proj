classdef Obstacle<handle
    %FOOD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    loc
    h
    end
    
    methods
    
    function initFood(obj,obs_loc,handle)
		obj.loc(1) = obs_loc(1);
		obj.loc(2) = obs_loc(2);
		obj.h = handle;
	end
    
    end
    
end

