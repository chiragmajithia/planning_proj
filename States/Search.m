seg_p = [];
for i = 1 : size(seg,1)
	seg_p(i) = seg(i).p;
end
indx = roulette(seg_p);
sprintf('moving to the segment %d to search',indx);
squirrel1.move2Seg(indx(1),1000);

