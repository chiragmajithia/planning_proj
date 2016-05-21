i = 1;
while i <= size(seg,1)
    
    neighbors = seg(i).n;
    seg(i).visible(true);
    seg(i).h.FaceColor = 'r';
    if(visual_run)
    for j = 1:size(neighbors)
        if(neighbors(j)>i)
        squirrel = Agent;
        seg(neighbors(j)).visible(true);
        squirrel.spawn();
        squirrel.path_ = cell2mat(seg(i).p2n(neighbors(j)))
        squirrel.moveAlongPath(100000);
        delete(squirrel.handle)
    end
    end
    pause(0.1)
    j
    end
    %input('check');
    seg(i).visible(false);
    seg(i).h.FaceColor = 'g';
    for j = 1:size(neighbors)
        seg(neighbors(j)).visible(false);
    end
    i = i + 1;
end