function [ output_args ] = initCache( cache_arr,cache_handle )
global cache
size(cache_arr)
for i = 1:size(cache_arr,1)
	cache(i).initCache(i,cache_arr(i,:),cache_handle(i,:));
end
end

