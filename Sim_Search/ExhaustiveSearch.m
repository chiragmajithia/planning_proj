
%% Perform Search and place food in randomly selected cache
global visual_run
squirrel1.task_id = squirrel1.FREE
seg_indx = randperm(size(seg,1));
i = 1;
while i <= size(seg_indx,2)
f = searchInSeg(seg_indx(i),squirrel1,10,0.9);
if(f == 1)
    continue;
end
i = i + 1;
end