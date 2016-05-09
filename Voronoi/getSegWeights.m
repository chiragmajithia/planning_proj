function [weights, p, area ] = getSegWeights(pos)
	global seg
	for i = 1 : size(seg,1)
		area(i,1) = seg(i).a;
		p(i,1) = mean(mean(seg(i).p_map));
		weights(i,1) = area(i,1) * p(i,1);
	end

	for i = 1 :size(seg,1)
		seg_c(i,:) = [seg(i).c.x,seg(i).c.y];
	end
	pos = repmat(pos,size(seg,1),1);
	dist = pos - seg_c;
	dist = hypot(dist(:,1),dist(:,2));
	dist = dist / max(dist);
	weights = weights - 10*dist;

end

