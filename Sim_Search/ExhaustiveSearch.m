global visual_run
squirrel1.task_id = squirrel1.FREE
n = 10;
thres = 0.9;
f_found = 0;
f = 10;
i = 1;
squirrel1.move([seg(1).o.x,seg(1).o.y])
last_pos = [squirrel1.pos.x,squirrel1.pos.y]
d = 1;
while(f_found <= f)
indx = i;
%input(strcat('seg selected',num2str(indx(1))));
[f_cnt, last_pos,d] = exhaustiveSearchInSeg(indx(1),squirrel1,last_pos,d);
squirrel1.move2Pos(last_pos,100);
last_pos
d
f_found = squirrel1.f_cnt;
if f_cnt>0
i = i - 1;
end
i = i + 1;
end
