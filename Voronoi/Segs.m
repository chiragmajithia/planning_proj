classdef Segs<handle
    %SEGS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    id%id numbers = should remain array index -kept to ensure if we need to delete any
    c %center
    o %origin
    d %dim dw,dh
    a %area
    n %neighbors = []
    h %handle
    r %rectangle
    p2n = {} %path to neighbor
    fw_loc =[[]] %pos.x in world %pos.y in world %id in food arr
    fs_loc =[[]] %pos.x in seg %pos.y in seg %id in food() arr
    p_map
    p %measure of coverage 0 means covered 1 means free
    food_map
    positive_bias 
    visual_uncertainity

    end
    
    methods

        function initFilters(obj,fig)
            global map_handle
            p_g = Gaussian_filter(15,2);
            p_ff = Gaussian_filter(11,4);
            p_ff = max(max(p_ff)) - p_ff;
            obj.visual_uncertainity = (p_ff /max(max(p_ff)));
            obj.positive_bias = makeFilter(p_g,obj.fs_loc,size(obj.p_map));
            obj.p_map = obj.positive_bias + obj.p_map;
            obj,p = mean(mean(obj.p_map))
            if(~isempty(fig))
                figure(fig);
                subplot(6,6,obj.id)
                surfc(obj.p_map);
                subplot(6,6,33)
                surf(obj.visual_uncertainity);
                figure(map_handle)
                %input('init pribability');
            end
        end

        function init(obj,seg,handle,id)
            obj.id = id
            obj.c.x = round(seg(1));
            obj.c.y = round(seg(2));
            obj.o.x = seg(3);
            obj.o.y = seg(4);
            obj.d.w = seg(5);
            obj.d.h = seg(6);
            obj.a = seg(7);
            obj.h = handle;
            obj.h.Visible = 'off';
            obj.r = [obj.o.x,obj.o.y,obj.d.w,obj.d.h];
            obj.p = 1;
            obj.p_map = ones(obj.d.w,obj.d.h)
        end

        function initHandles(obj,handle)
            obj.h = handle;
            obj.h.Visible = 'off';
        end

        function visible(obj,val)
            if val == false
                obj.h.Visible = 'off';
            else
                obj.h.Visible = 'on';
            end
        end

        function addPath(obj,path,n)
            p2n{n} = path;
        end

        function addFood(obj,arr)
            obj.fw_loc = [obj.fw_loc;arr];
            fs_loc = [(arr(:,1)-obj.o.x),(arr(:,2)-obj.o.y),(arr(:,3))]
            obj.fs_loc = [obj.fs_loc;fs_loc]
            sprintf('%d food added',size(obj.fs_loc,1))
        end

        function initFoodMap(obj,v_r)
            obj.food_map = zeros(obj.d.w,obj.d.h);
            for i = 1: size(obj.fs_loc,1)
                sprintf('food_loc %d,%d',obj.fs_loc(i,1),obj.fs_loc(i,2))
                obj.food_map = patchCircle(v_r,obj.fs_loc(i,1),obj.fs_loc(i,2),obj.fs_loc(i,3),obj.food_map);
            end
        end

        function [p_w,p_s] = generateVertices(obj,n,thres)
            max_p = max(max(obj.p_map));
            min_p = min(min(obj.p_map));
            if(max_p ~= min_p)
            n_map = (obj.p_map - min_p)/(max_p-min_p);
            else
                n_map = obj.p_map/max_p;
            end
            p_w = [];
            p_s = [];

            [r,c] = find(n_map > thres);
            sprintf('Number of selected indices = %d',size(r))
            for i = 1 : n
                indx =randi([1,size(r,1)]);
                x_s = r(indx);
                y_s = c(indx);
                x_w = x_s + obj.o.x;
                y_w = y_s + obj.o.y;
                p_w = [p_w;[x_w,y_w]];
                p_s = [p_s;[x_s,y_s]];
            end
        end

        function p = generateExhaustiveSearch(obj,agent,v_r,d)

            step_x = v_r;
            step_y = v_r*d;
            if(step_x < 1)
                step_x = 1;
            end
            flag = 0;
            p = [agent.pos.x,agent.pos.y];
            i = agent.pos.x;
            j = agent.pos.y;
            while (i <= obj.o.x + obj.d.w &&  i + step_x >= 1)
                while (j < obj.o.y+ obj.d.h - step_y && j + step_y >=0)
                    flag = 1;
                    j = j + step_y;
                    p = [p;[i,j]];
                end 
                d = d * -1;
                step_y = v_r * d;
                i = i + step_x;
                %step_x
                %p
                %input('check')
            end 
            
        end

        function removeFood(obj,f_id)
             indx = [];
             f_temp = obj.fw_loc;
             for i = 1:size(f_id,1)
                 indx = [indx;find(obj.fw_loc(:,3) == f_id(i))];
             end
             obj.fw_loc(indx,:) = [];
             obj.fs_loc(indx,:) = [];
         end

         function patchProb(obj,pos_w, fig)
            global map_handle
            flag = 0;
            if(nargin > 2)
                flag = 1;
            end
            x = pos_w(1) - obj.o.x;
            y = pos_w(2) - obj.o.y;
            obj.p_map = patchProb(x,y,obj.p_map,obj.visual_uncertainity );

            if(flag)
                figure(fig);
                fig.set('Position',[1106 378 560 420]);
                title(strcat('Seg',num2str(obj.id)))
                %subplot(6,6,obj.id)
                surfc(obj.p_map);
                figure(map_handle);
            end

         end

    end
    
end


