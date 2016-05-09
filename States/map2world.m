function [ locs ] = map2world( indx,locs )
    global seg
    o = seg(indx).o
	locs = [(locs(:,1)+o.x),(locs(:,2)+o.y),(locs(:,3))]
end

