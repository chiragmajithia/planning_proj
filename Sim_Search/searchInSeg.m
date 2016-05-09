function [ found_food ] = searchInSeg( seg_indx,squirrel1,n,thres )
global visual_run seg cache
found_food = 0;
seg_cent = [seg(seg_indx).c.x,seg(seg_indx).c.y];
squirrel1.move2Pos(seg_cent,100);
%%squirrel Moved to interested seg;

[pos_w,~]=seg(seg_indx).generateVertices(n,thres)

%this returns n vertices in pos_w (ignoring segment coordinates)
%thres uses the probability map of the segment and gives vertices above thres
squirrel1.task_id = squirrel1.SEARCH
curr_status = squirrel1.task_id;
i = 1;
while(~isempty(pos_w) && curr_status == squirrel1.SEARCH)
    curr_pos = [squirrel1.pos.x squirrel1.pos.y];
    curr_pos = repmat(curr_pos,size(pos_w,1),1);
    dist = pos_w - curr_pos;
    dist = hypot(dist(:,1),dist(:,2));
    [~,indx] = min(dist)
    nxt_pos = pos_w(indx,:)
    pos_w(indx,:) = []
    squirrel1.move2Pos(nxt_pos,100);
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
    found_food = 1;
    c_id = nearestCache([squirrel1.pos.x,squirrel1.pos.y]);
    f_id = str2num(squirrel1.temp_input{2});
    %c_id = ones(size(f_id)).*randi(size(cache,1),size(f_id,1),1);
    c_id = ones(size(f_id))*c_id;
    fc_id = [f_id c_id];
    squirrel1.pickFood(fc_id,1000)
    fc_id;
end
visual_run = 1;
end

