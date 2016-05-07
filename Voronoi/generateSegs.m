function [ merge_seg,seg_handle ] = generateSegs(x_axis,y_axis)
    global map visual_run
    load('variables/constants')
    segs = [];
    y_ = x_axis;
    x_ = y_axis;
    cnt = 1;
    for i = 1:size(x_,1)-1
        for j = 1:size(y_,1)-1
            p = [x_(i),y_(j)];
            dx = x_(i+1)-x_(i);
            dy = y_(j+1)-y_(j);
            p = [p dx dy];

            center = [p(1)+dx/2,p(2)+dy/2];
            area = dx*dy;
            if(map(int16(center(1)),int16(center(2))) == OBS_VAL)
                continue;
            else
                if(visual_run)
                    recs(cnt,:) = rectangle('Position',p,'FaceColor','none');
                    pause(0.01);
                end
                segs(cnt,:) = [center(1),center(2),x_(i),y_(j),dx,dy,area];
                cnt=cnt+1;

            end
        end
    end

    seg_size = size(segs,1);
    cnt = 1;
    i = 1;
    x_max = 0;
    y_max = 0;

    while (i+1) <= size(segs,1)
        seg1 = segs(i,:);
        while (i+1) <= size(segs,1)
            seg2 = segs(i+1,:);
            c1_x = seg1(1);
            c2_x = seg2(1);
            c1_y = seg1(2);
            c2_y = seg2(2);
            if(round(c1_x) == round(c2_x))
                %sprintf('Computing Line of Sight %d,%d %d,%d',c1_x,c1_y,c2_x,c2_y)
                if(lineOfSight(c1_x,c1_y,c2_x,c2_y))
                    o = seg1(3:4);
                    dx = seg1(5);
                    dy = seg1(6) + seg2(6);
                    area = dx*dy;
                    c1_y = o(2)+dy/2;
                    c1_x = c1_x;
                    seg1 = [c1_x,c1_y,o(1),o(2),dx,dy,area];
                    i = i + 1;
                else
                    i = i + 1;
                    break;
                end
            else
                i = i + 1;
                break
            end
        end
        merge_seg(cnt,:) = seg1(:);
        %sprintf('merged seg')
        seg_handle(cnt,:) = rectangle('Position',merge_seg(cnt,3:6),'FaceColor','g');
        %seg_handle(cnt).Visualize = 'on'
        cnt = cnt + 1;
    end

    X = merge_seg(:,1);
    Y = merge_seg(:,2);
    if(visual_run)
        centers = plot(X,Y,'x')
        pause(1)
        delete(centers);
        delete(recs);
    end
end