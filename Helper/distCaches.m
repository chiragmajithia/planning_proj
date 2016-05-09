function [ dist ] = distCaches( pos_w )
global cache
cnt = 1;
for i = 1 : size(cache,1)
        cache_loc(cnt,:) = cache(i).loc;
        cnt = cnt + 1;
end
pos_w = repmat(pos_w,size(cache_loc,1),1);
dist = pos_w - cache_loc;
dist = hypot(dist(:,1),dist(:,2));
end

