close all;
clear all;
load('main')
squirrel1.task_id = 0
squirrel1.move2Pos(food(16).loc-[15,15],100)
input('continue')
squirrel1.task_id = 1
squirrel1.move2Pos(food(16).loc-[5,-5],100)
c_id = nearestCache([squirrel1.pos.x,squirrel1.pos.y])
squirrel1.pickFood([str2num(squirrel1.temp_input{2}),[c_id;c_id]],100)