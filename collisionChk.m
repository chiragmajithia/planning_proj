function r = collisionChk(nP,Goal,Obst_loc)
x1 = nP(1);
y1 = nP(2);
x2 = Goal(1);
y2 = Goal(2);
r = 0;
syms x y;
f = (y2-y1)*(x-x1) - (x2 - x1)*(y-y1);
norm_factor = norm([x2-x1 y2-y1]);
for i = 1:size(Obst_loc,1)
    if(abs(eval(subs(f,[x y],Obst_loc(i,1:2))))/norm_factor < Obst_loc(i,3))
        r = 1;
        return;
    end
end

end