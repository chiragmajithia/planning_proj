name = 'variables/seg_';
name = strcat(name,int2str(seed),'.mat')
if(exist(name)==2 && fast_run)
    sprintf('values loaded')
    [x_ax,y_ax] = generateLines();
    [merged_segs,seg_handles]=generateSegs(x_ax,y_ax);
    load(name);
    for i = 1 : size(seg)
        seg(i).initHandles(seg_handles(i,:));
    end
else
    [x_ax,y_ax] = generateLines();
    [merged_segs,seg_handles]=generateSegs(x_ax,y_ax);
    seg(size(merged_segs,1),1) = Segs;
    for i = 1 : size(seg)
        seg(i).init(merged_segs(i,:),seg_handles(i,:),i);
    end
    
    i = 1
    j = 1
    
    while i <= size(seg,1)
        sprintf('seg(%d)',i)
        seg(i).visible(true);
        j = 1;
        while j <= size(seg,1)
            if(isNeighbor(seg(i).r,seg(j).r) && i~=j)
                seg(j).visible(true);
                seg(i).n = [seg(i).n;j];
                try
                    p2n = seg(i).p2n{j}
                catch exp
                    %getReport(exp)
                    p2n = {};
                end
                if(isempty(p2n))
                    s_p = [seg(i).c.x, seg(i).c.y];
                    g_p = [seg(j).c.x, seg(j).c.y];
                    sprintf('calculating path.. %d and %d',i,j);
                    path =Astar(s_p,g_p,map);
                    seg(i).p2n{j} =  flipud(path);
                    seg(j).p2n{i} = path;
                    sprintf('path_calculated between %d and %d',i,j);
                else
                    sprintf('path_exists');
                end
                pause(0.1);
                seg(j).visible(false);
            end
            j = j + 1;
        end
        seg(i).visible(false);
        i = i + 1;
    end
    assignFood();
    save(name,'seg');
end

%neighborCheck;

if(visual_run)
    assignFoodCheck();
end


seg_graph = configSegGraph();
prob = figure;
for i = 1 : size(seg)
    seg(i).initFilters(prob)
end
