classdef Cache<handle
    
    
    properties
    id
    loc
    last_visited
    elapse_time
    f_id
    h
    capacity
    space_available
    f_n;
    patrol = false;
    end
    
    methods
    
    function initCache(obj,id,cache_arr,handle)
    	obj.id = id;
    	obj.loc(1) = cache_arr(1)+cache_arr(3);
    	obj.loc(2) = cache_arr(2)+cache_arr(3);
    	obj.capacity = ceil(randi([1,3])*cache_arr(3)/8);
    	obj.last_visited = clock();
    	obj.elapse_time = etime(clock(),obj.last_visited);
    	obj.f_id = [[]];

    	obj.h = handle;
    	obj.space_available = obj.capacity;
    	obj.f_n = 0;
    	obj.patrol = false;
    end

    function visited(obj)
    	obj.elapse_time = etime(clock(),clock());
    	obj.last_visited = clock();
        sprintf('visited %d',obj.id)
        obj.h.FaceColor = 'g'; 
    end

    function e_time = elapseTime(obj)
    	obj.elapse_time = etime(clock(),obj.last_visited);
    	e_time = obj.elapse_time;
    end

    function addFood(obj,f_id)
    	obj.f_id = [obj.f_id;f_id];
    	obj.space_available = obj.capacity - size(obj.f_id,1);
    	obj.f_n = size(obj.f_id,1);
    	obj.patrol = true;
    end

    function pilfer()
    	obj.space_available = obj.capacity
    	obj.f_id = [];
    end
    
    end
end

