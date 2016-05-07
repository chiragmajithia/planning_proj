classdef Segs<handle
    %SEGS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    id%id numbers = should remain array index -kept to ensure if we need to delete any
    c %center
    o %origin
    d %dim dx,dy
    a %area
    n %neighbors = []
    h %handle
    r %rectangle
    p2n = {} %path to neighbor
    f_loc =[] %pos.x in seg %pos.y in seg %id in food arr
    p_map
    p %measure of coverage 0 means covered 1 means free
    end
    
    methods
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

    end
    
end

