classdef list<handle
    %LIST Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
	    arr;
	end

	methods
		function append(obj,vertex)
			obj.arr(end+1,:) = vertex;
		end

		function cat(obj,arr)
			if ~isempty(obj.arr)
			obj.arr = [obj.arr;arr];
			else
			obj.arr = arr;
			end
		end

		function v = popLast(obj)
			if ~isempty(obj.arr)
				v = obj.arr(end,:);
				obj.arr = obj.arr(1:end-1,:);
			else
				v = 0;
			end
		end

		function v = popFirst(obj)
			if ~isempty(obj.arr)
				v = obj.arr(1,:);
				obj.arr = obj.arr(2:end,:);
			else
				v = 0;
			end
		end
	end

end
