classdef Agent<handle
   
   properties
   	  name = 'Agent'
      pos = struct('x',0.0,'y',0.0);
      path_ = [];
      handle = [];
   end


   methods
      
      function [] = spawn(obj)
      	 x = randi([1 299]);
   		 y = randi([1 299]);
   		 if ~isempty(obj.handle)
        	disp('Object exists');
     	 else
     	 	obj.handle = rectangle('Position',[x,y,10,10],'FaceColor','m');
     	 end
      end

      function [] = move(obj,pos2)
      	position = [pos2 obj.handle.Position(3:4)]
      	obj.handle.Visible = 'off'
      	obj.handle = rectangle('Position',position,'FaceColor',obj.handle.FaceColor)
      end 

      function [] = setName(obj,name_)
      	obj.name = name_
      end

      function []= movePath(obj,v)
      	h = obj.plotPath();
      	dist = obj.pathDistance()
      	t = dist/v;
      	[r,c] = size(obj.path_);
      	for i = 1:r
      		obj.move(obj.path_(i,:));
      		pause(t/r);
      	end
      	set(h,'XData',[],'Ydata',[]);
      end

      function h = plotPath(obj)
      	X = obj.path_(:,1);
      	Y = obj.path_(:,2);
      	h = line(X,Y);
      end
      
      % function []= movePath(obj,v)
      % 	dist = obj.pathDistance()
      % 	t = dist/v;
      % 	[r,c] = size(obj.path_);
      % 	for i = 1:r
      % 		obj.move(obj.path_(i,:));
      % 		pause(t/r);
      % 	end
      % end
      
      function [] = addVertex(obj,v)
      	obj.path_ = [obj.path_; v]
      end
      
      function [] = setColor(obj,c)
      	obj.handle.FaceColor = c;
      end

      function dist = pathDistance(obj)
      	[r,c] = size(obj.path_)
      	dist = 0;
      	for i = 1:r-1
      		d_pos = obj.path_(i,:)-obj.path_(i+1,:);
      		dist = dist + hypot(d_pos(1),d_pos(2));
      	end
   	  end
   	end
end