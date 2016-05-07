function p_map = patchProb(x,y,p_map,p_ff)
    dx = floor(size(p_ff,1)/2);
    dy = floor(size(p_ff,2)/2);
    max_x = size(p_map,1);
    max_y = size(p_map,2);
    fx = 0;
    fy = 0;
    for i = x-dx : x+dx
        fx = fx + 1;
        if(i > 0 && i <= max_x)
           for j = y -dy: y + dy
               fy = fy + 1;
               %sprintf('(%d,%d) maps to (%d,%d)',fx,fy,i,j)
               if(j>0 && j <= max_y)
                p_map(i,j) = p_map(i,j) * p_ff(fx,fy);
               end
            end
        end
        fy = 0;
    end

end