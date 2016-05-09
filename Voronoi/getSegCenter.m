function [ center ] = getSegCenter( indx )
	global seg
	center = [seg(indx).c.x,seg(indx).c.y]
end

