function [ found_food, last_pos,d ] = exhaustiveSearchInSeg( seg_indx,squirrel1,last_pos,d )
global visual_run seg cache
found_food = 0;
%%squirrel Moved to interested seg;
seg_indx = squirrel1.getCurrSeg();

pos_w=seg(seg_indx).generateExhaustiveSearch(squirrel1,10,d);

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
    %d = sign(nxt_pos(2) - curr_pos(2))
    squirrel1.move2Pos(nxt_pos,1000);
    i = i  + 1;
    curr_status = squirrel1.task_id    
end
sprintf('last_pos')
last_pos = [squirrel1.pos.x,squirrel1.pos.y];
d = -1*sign(last_pos(2) - nxt_pos(2));
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

