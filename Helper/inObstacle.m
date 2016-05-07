function r = inObstacle(newP,Obst_loc)
r = 0;
for i = 1:size(Obst_loc,1)
    if(norm(newP-Obst_loc(i,1:2)) < Obst_loc(i,3))
        r = 1;
        return;
    end
end

end