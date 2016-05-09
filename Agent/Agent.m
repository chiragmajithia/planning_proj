classdef Agent<handle
    
    properties
        
        name = 'Agent'
        pos = struct('x',0.0,'y',0.0);
        path_ = [];
        handle = [];
        task_id;
        temp_input;
        f_cnt;
    end
    
    properties(Constant)
        FREE = 0;
        SEARCH = 1;
        PICK = 2;
        PATROL = 3;
        DECEIVE = 4;
    end
    
    
    methods
        
        %{ Initilization functions%}
        function [] = setName(obj,name_)
            obj.name = name_;
        end
        
        function [] = setColor(obj,c)
            obj.handle.FaceColor = c;
        end
        
        
        function [] = spawn(obj)
            if ~isempty(obj.handle)
                disp('Object exists');
            else
                x = randi([1 299]);
                y = randi([1 299]);
                obj.handle = rectangle('Position',[x,y,10,10],'FaceColor','m');
                obj.pos.x = x;
                obj.pos.y = y;
                obj.task_id = obj.FREE
                obj.f_cnt = 0;
            end
        end
        %{ Path genration and moving functions%}
        function [] = move(obj,pos2)
          global map_handle
          figure(map_handle);
            position = [pos2 obj.handle.Position(3:4)];
            obj.handle.Visible = 'off';
            obj.handle = rectangle('Position',position,'FaceColor',obj.handle.FaceColor);
            obj.pos.x = pos2(1)+5;
            obj.pos.y = pos2(2)+5;
            obj.performTask(obj.temp_input);
        end
        
        function []= moveAlongPath(obj,v)
            if(~isempty(obj.path_) && v~=0)
                h = obj.plotPath();
                dist = obj.pathDistance();
                t = dist/v;
                [r,c] = size(obj.path_);
                for i = 1:r
                    if (isequal(size(obj.path_),[r,c]))
                        obj.move(obj.path_(i,:)-[5 5]);
                        pause(t/r);
                    else
                        sprintf('Path Flushed!')
                        %input('check')
                        break;
                    end
                end
                set(h,'XData',[],'Ydata',[]);
            else
                sprintf('Path empty or v = 0')
            end
        end
        
        function dist = pathDistance(obj)
            [r,c] = size(obj.path_);
            dist = 0;
            for i = 1:r-1
                d_pos = obj.path_(i,:)-obj.path_(i+1,:);
                dist = dist + hypot(d_pos(1),d_pos(2));
            end
        end
        
        function h = plotPath(obj)
            X = obj.path_(:,1);
            Y = obj.path_(:,2);
            h = line(X,Y);
        end
        
        function move2Pos(obj,pos2,v)
            obj.path_ = obj.genPath2(pos2);
            obj.moveAlongPath(v);
        end
        function move2Seg(obj,dest,v)
            start = obj.getCurrSeg();
            obj.path_ = getPath2Seg(start,dest);
            obj.moveAlongPath(v);
        end
        
        function path = genPath2(obj,pos2)
            pos1 = [(obj.pos.x),(obj.pos.y)];
            seg1_indx = getSeg([obj.pos.x,obj.pos.y]);
            sprintf('%d,%d in seg %d',pos1(1),pos1(2),seg1_indx)
            seg2_indx = getSeg([pos2(1),pos2(2)]);
            if(seg2_indx == 0)
                sprintf('%d,%d is inside obstacle or out of map',pos2(1),pos2(2))
                path = [];
            else
                sprintf('%d,%d in seg %d',pos2(1),pos2(2),seg2_indx)
                [v,p] = pathLoS(pos1,pos2);
                if(v)
                    path = p;
                else
                    seg1_center = getSegCenter(seg1_indx);
                    [v1,p1] = pathLoS(pos1,seg1_center);
                    p2 = getPath2Seg(seg1_indx,seg2_indx);
                    [v3,p3] = pathLoS(p2(end,:),pos2);
                    path = [p1;p2;p3];
                    path = obj.optimizedPath(path,0.1);
                end
            end
            
        end
        
        function path = optimizedPath(obj,path,div_per)
            l = size(path,1);
            step = ceil(l*div_per);
            indices = 2:step:l;
            landmarks = path(indices,:);
            for i = 1:size(landmarks,1)
                [v,p] = lineOfSight(landmarks(i,1),landmarks(i,2),path(end,1),path(end,2));
                if(v == 1)
                    [v,p] = pathLoS(landmarks(i,:),path(end,:));
                    sprintf('optimizedPath');
                    path = path(1:indices(i),:);
                    path = [path;p];
                    break;
                else
                    sprintf('not optimmized');
                end
            end
        end
        
        
        %{Locates food if in current Seg - if in threshold returns food location in world and segment coordinates%}
        function [pos_w,pos_s] = locateFood(obj,v_r)
            global seg visual_run map_handle
            seg_id = obj.getCurrSeg();
            fw_loc = seg(seg_id).fw_loc;
            x = obj.pos.x;
            y = obj.pos.y;
            pos_w = [];
            pos_s = [];
            if(~isempty(fw_loc))
                for i =  1: size(fw_loc,1)
                    p = fw_loc(i,:);
                    dx = x - p(1);
                    dy = y - p(2);
                    dist_(i) = hypot(dx,dy);
                end
                
                [~,indx] = find(dist_<=v_r);
                if(~isempty(indx))
                    pos_w  = fw_loc(indx,:);
                    pos_s = seg(seg_id).fs_loc(indx,:)
                    obj.f_cnt = obj.f_cnt + size(pos_w,1);
                    if visual_run
                        figure(map_handle);
                        r = [];
                        for i = 1 : size(pos_w,1)
                            r(i) = rectangle('Position',[x-dist_(indx(i)),y-dist_(indx(i)),2*dist_(indx(i)),2*dist_(indx(i))],'EdgeColor','r','Curvature',1);
                        end
                        %input('check');
                        delete(r);
                    end
                end
            end        
            f = figure(4);
            figure(map_handle);
            seg(seg_id).patchProb([x,y],f)
            pause(0.0001);
        end
        
        function pickFood(obj,f_c_id,v)
            global seg food cache;
            f_id = f_c_id(:,1);
            c_id = f_c_id(:,2);
            for i = 1:size(f_id,1)
                f_loc = food(f_id(i)).loc;
                cache(c_id(i)).addFood(f_id(i));
                obj.move2Pos(f_loc,v);
                %input('Picked food')
                sprintf('Picked Food');
                pause(0.5);
                obj.temp_input = {'food_id',int2str(f_id(i))}
                obj.task_id = obj.PICK;
                food(f_id(i)).pick = false;
                food(f_id(i)).c_id = c_id(i);
                food(f_id(i)).h.Visible = 'off';
                seg(food(f_id(i)).s_id).removeFood(f_id(i));
            end
            obj.temp_input = {'food_id',int2str(f_id(i))}
            pause(0.01);
            c_id = unique(c_id,'stable');
            for i = 1 : size(c_id,1)
                c_loc = cache(c_id(i)).loc;
                sprintf('Moving towards goal')
                obj.move2Pos(c_loc,v);
                food(f_id(i)).h.Visible = 'off';
                sprintf('Food Dropped')
                cache(c_id(i)).visited();
            end
            obj.task_id = obj.FREE; %%Change it to free
            obj.temp_input = {};
            
            %seg_.removeFood(f_id)
        end
        
        function [id] = getCurrSeg(obj)
            id = getSeg([obj.pos.x,obj.pos.y]);
        end
        
        
        %Probably
        function [] = addVertex(obj,v)
            obj.path_ = [obj.path_; v];
        end
        
        function performTask(obj,inputs)
            
            sprintf('obj.task_id');
            switch obj.task_id
                case obj.PICK
                    obj.pickTask(inputs);
                    
                case obj.SEARCH
                    obj.searchTask();
                    if(obj.f_cnt >= 10)
                        sprintf('Search Complete for %d food!',obj.f_cnt);
                        obj.task_id = obj.PATROL;
                    end

                case obj.PATROL
                    if(isequal(obj.path_(end,:),[obj.pos.x-5,obj.pos.y-5]))
                        [~,indx] = find(strcmp(inputs,'PATROL'));
                        id = str2num(inputs{indx+1})
                        cache(id).visited();
                        sprint('patrol finish')
                    else
                        sprintf('running')
                    end
                otherwise
                    
            end
        end
        
        function searchTask(obj)
            [pos_w, pos_s] = obj.locateFood(15);
            if(~isempty(pos_w))
                obj.path_ = [];
                obj.task_id = obj.PICK;
                obj.temp_input = {'food_id',int2str(pos_w(:,3))};
            end
        end
        
        function pickTask(obj,inputs)
            global food
            [~,indx] = find(strcmp(inputs,'food_id'));
            id = str2num(inputs{indx+1});
            position = food(id(1)).h.Position; %%Work on multiple indexing
            position(1:2) = [obj.pos.x,obj.pos.y];
            food(id(1)).h.Visible = 'off';
            food(id(1)).h = rectangle('Position',position,'EdgeColor','y');
        end
        
    end
end

%{
	TODO:
	moveStep()
%}