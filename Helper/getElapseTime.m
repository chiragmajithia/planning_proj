function [ e_time ] = getElapseTime()
global cache
for i = 1 : size(cache,1)
	e_time(i,1) = cache(i).elapseTime();
end
end

