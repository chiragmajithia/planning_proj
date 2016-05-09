function [ f_cnt ] = cacheFood()
global cache
for i = 1 : size(cache,1)
 	f_cnt(i,1) = cache(i).f_n;
end
end

