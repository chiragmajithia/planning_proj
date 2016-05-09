function [ locs ] = searchAlgo( indx )
addpath('MonteCarlo');
[food_map,food_loc] = genFoodMap(indx,1);
locs = searchFood(food_map,food_loc,15,10);
locs = map2world(indx,locs)
end

