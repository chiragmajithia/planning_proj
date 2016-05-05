function plot(ax,ay)
	width = 500;
	X = 1 : width;
	for i = 1:size(ax,1)
		Y = ax(i) * ones(width);
		plot(X,Y);
		pause(0.1);
	end

	height = 300;
	Y = 1 : height;
	for i = 1:size(ay,1)
		X = ay(i) * ones(height);
		plot(X,Y);
		pause(0.1);
	end
end