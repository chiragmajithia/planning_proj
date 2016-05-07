classdef Agent<handle
   
   properties

   	name = 'Agent'
      pos = struct('x',0.0,'y',0.0);
      path_ = [];
      handle = [];
   end


   methods
      
      function [] = spawn(obj)
   		 if ~isempty(obj.handle)
        	disp('Object exists');
     	 else
          x = randi([1 299]);
          y = randi([1 299]);
     	 	obj.handle = rectangle('Position',[x,y,10,10],'FaceColor','m');
         obj.pos.x = x;
         obj.pos.y = y;
     	 end
      end

      function [] = move(obj,pos2)
      	position = [pos2 obj.handle.Position(3:4)];
      	obj.handle.Visible = 'off';
      	obj.handle = rectangle('Position',position,'FaceColor',obj.handle.FaceColor);
         obj.pos.x = pos2(1)+5;
         obj.pos.y = pos2(2)+5;
      end 

      function [] = setName(obj,name_)
      	obj.name = name_;
      end

      function []= movePath(obj,v)
        if(~isempty(obj.path_) && v~=0)
      	h = obj.plotPath();
      	dist = obj.pathDistance();
      	t = dist/v;
      	[r,c] = size(obj.path_);
      	for i = 1:r
      		obj.move(obj.path_(i,:)-[5 5]);
      		pause(t/r);
      	end
      	set(h,'XData',[],'Ydata',[]);
        else
            sprintf('Path empty or v = 0')
        end
      end

      function h = plotPath(obj)
      	X = obj.path_(:,1);
      	Y = obj.path_(:,2);
      	h = line(X,Y);
      end
      
      function move2Seg(obj,dest,v)
         start = obj.getCurrSeg();
         obj.path_ = getPath2Seg(start,dest);
         obj.movePath(v);

      end
      
      function [] = addVertex(obj,v)
      	obj.path_ = [obj.path_; v];
      end
      function [id] = getCurrSeg(obj)
         id = getSeg([obj.pos.x,obj.pos.y]);
      end
      function [] = setColor(obj,c)
      	obj.handle.FaceColor = c;
      end

      function dist = pathDistance(obj)
      	[r,c] = size(obj.path_);
      	dist = 0;
      	for i = 1:r-1
      		d_pos = obj.path_(i,:)-obj.path_(i+1,:);
      		dist = dist + hypot(d_pos(1),d_pos(2));
      	end
   	  end
   	end
end

%{
	TODO:
	moveStep()
%}