function [ indices ] = findPatrolCaches()
global cache
indx = [];
for i = 1:size(cache,1)
	if(cache(i).patrol)
		indx = [indx;i];
	end
end

end

