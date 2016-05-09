global visual_run
squirrel1.task_id = squirrel1.FREE
n = 3;
thres = 0.9;
f_found = 0;
f = 10;
while(f_found <= f)
[weights,~,~] = getSegWeights([squirrel1.pos.x,squirrel1.pos.y]);
indx = roulette(weights);
%input(strcat('seg selected',num2str(indx(1))));
f_cnt = searchInSeg(indx(1),squirrel1,n,thres);
f_found = f_cnt + squirrel1.f_cnt;
end
