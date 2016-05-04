Pos(1,:) = [10 10];
Goal = [270 270];

for i = 1:1000
    dx = Goal(1) - Pos(i,1);
    dy = Goal(2) - Pos(i,2);
    adx = abs(dx);  
    ady = abs(dy);
    if(adx>ady)
        newP = Pos(i) + (dx/adx)*[1 0];
    elseif (adx<ady)
        newP = Pos(i) + (dy/ady)*[0 1];
    else
        newP = Pos(i) + [(dx/adx) (dy/ady)];
    end
    hold on;
    if(collisionChk(Pos(i,:),Goal,Obst_loc))
        while(1)
        if(inObstacle(newP,Obst_loc))
            newP = Pos(i) + randi([-1 1], [1 2]);
            if(newP(1) == Pos(i,1) && newP(2) == Pos(i,2))
                continue;
            end
        else
            break;
        end
        end
%             
%     else
%         Pos(i+1,:) = newP;
    end
    Pos(i+1,:) = newP
   plot([Pos(i,1) Pos(i+1,1)], [Pos(i,2) Pos(i+1,2)]); 
   if(Pos(i+1,1) == Goal(1) && Pos(i+1,2) == Goal(2))
       break;
   end
   drawnow;
end
hold off;