function [ filter ] = makeFilter(gf,locs,size_ )
	filter = zeros(size_);
	dx = floor(size(gf,1)/2);
	dy = floor(size(gf,2)/2);
	max_x = size_(1);
	max_y = size_(2);
	fx = 0;
	fy = 0;
	for pos = 1:size(locs,1)
		x = locs(pos,1);
		y = locs(pos,2);
        	fx = 0;
	fy = 0;
		for i = x-dx : x+dx
			fx = fx + 1;
			if(i > 0 && i <= max_x)
				for j = y -dy: y + dy
					fy = fy + 1;
               %sprintf('(%d,%d) maps to (%d,%d)',fx,fy,i,j)
               if(j>0 && j <= max_y)
               	filter(i,j) = filter(i,j) + gf(fx,fy);
               end
           end
       end
       fy = 0;
   end
end

end

