global visual_run
squirrel1.task_id = squirrel1.FREE
n = 10;
thres = 0.9;
f_found = 0;
f = 10;
f_cnt =0 ;
while(f_found <= f)

%input(strcat('seg selected',num2str(indx(1))));
if(f_cnt>0)
	seg_indx = re_seg;
else
	[weights] = getSegWeights([squirrel1.pos.x,squirrel1.pos.y]);
	indx = roulette(weights);
    seg_indx = indx(1);
end
[f_cnt,re_seg] = searchInSeg(seg_indx,squirrel1,n,thres);
f_found = squirrel1.f_cnt;
end
