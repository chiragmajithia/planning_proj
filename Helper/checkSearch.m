
%% Perform Search and place food in randomly selected cache
global visual_run
squirrel1.task_id = squirrel1.FREE
seg_indx = randi([1,size(seg,1)]);
seg_cent = [seg(seg_indx).c.x,seg(seg_indx).c.y];
squirrel1.move2Pos(seg_cent,100);
%%squirrel Moved to interested seg;
n = 10;
thres = 0.95
[pos_w,~]=seg(seg_indx).generateVertices(n,thres)
%this returns n vertices in pos_w (ignoring segment coordinates)
%thres uses the probability map of the segment and gives vertices above thres
squirrel1.task_id = squirrel1.SEARCH
curr_status = squirrel1.task_id;
i = 1;
while(i <= n && curr_status == squirrel1.SEARCH)
    squirrel1.move2Pos(pos_w(i,1:2),100);
    i = i  + 1;
    curr_status = squirrel1.task_id    
end
dispFoodStatus();
visual_run = 0;
%% check comm_variable to ensure food was found!
if(squirrel1.task_id == squirrel1.SEARCH)
    sprintf('food NOT Found..Try Again')
    squirrel1.task_id = squirrel1.FREE;
else
    f_id = str2num(squirrel1.temp_input{2});
    c_id = ones(size(f_id)).*randi(size(cache,1),size(f_id,1),1);
    fc_id = [f_id c_id];
    squirrel1.pickFood(fc_id,100)
    fc_id
end
visual_run = 1;