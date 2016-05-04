rectangle('Position',[0 0 300 300]);
axis('equal')

for i = 1:30
    x = randi([1 299]);
    y = randi([1 299]);
    Food_loc(i,:) = [x y];
    Food_handle(i) = rectangle('Position', [x y 2 2], 'Curvature', [1 1], 'FaceColor', 'r');
end

for i = 1:10
    x = randi([20 280]);
    y = randi([20 280]);
    d = 4*randi([2 5]);
    d
    Obst_loc(i,:) = [x y d/2];
    Obst_handle(i) = rectangle('Position', [x y d d], 'Curvature', [1 1], 'FaceColor', 'b');
end

