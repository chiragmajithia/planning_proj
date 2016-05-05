function n =  getNeighbors(pos,s)
    pos
    x_max=s(1);
    y_max=s(2);
    x = pos(1);
    y = pos(2);

    east = [x-1,y];
    west = [x+1,y];
    
    north = [x,y+1];
    north_east = [x-1,y+1];
    north_west = [x+1,y+1];

    south = [x,y-1];
    south_east = [x-1,y-1];
    south_west = [x+1,y-1];

    n = [north_east;north;north_west;east;west;south_east;south;south_west];

end
