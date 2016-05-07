function [ x_axis,y_axis ] = generateLines()
global obs_loc map
[width,height] = size(map)
x_axis=[0];
y_axis=[0];
for i = 1 : size(obs_loc,1)
	x_axis = [x_axis;obs_loc(i,2);obs_loc(i,2)+obs_loc(i,3)];
    y_axis = [y_axis;obs_loc(i,1);obs_loc(i,1)+obs_loc(i,3)];
end
x_axis=[x_axis;height];
y_axis=[y_axis;width];
x_axis = unique(sort(x_axis));
y_axis = unique(sort(y_axis));

end

