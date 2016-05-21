function [weights] = getSegWeights(pos)
	global seg
	a = 10;
	b = -10;
	for i = 1 : size(seg,1)
		p(i,1) = mean(mean(seg(i).p_map))*seg(i).a;
	end

	for i = 1 :size(seg,1)
		seg_c(i,:) = [seg(i).c.x,seg(i).c.y];
	end
	pos = repmat(pos,size(seg,1),1);
	dist = pos - seg_c;
	dist = hypot(dist(:,1),dist(:,2));
	dist = dist / max(dist);

	p = p/max(p);

	weights = a*p + b*dist

end

