function [ x_axis,y_axis ] = generateLines()
global map obs
[width,height] = size(map)
x_axis=[0];
y_axis=[0];
for i = 1 : size(obs,1)
    i
	x_axis = [x_axis;obs(i).loc(2);obs(i).loc(2)+obs(i).loc(3)];
    y_axis = [y_axis;obs(i).loc(1);obs(i).loc(1)+obs(i).loc(3)];
end
x_axis=[x_axis;height];
y_axis=[y_axis;width];
x_axis = unique(sort(x_axis));
y_axis = unique(sort(y_axis));

end

