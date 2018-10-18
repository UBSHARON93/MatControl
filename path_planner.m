xlimit = [3 13];
ylimit = [2  8];
xbox = xlimit([1 1 2 2 1]);
ybox = ylimit([1 2 2 1 1]);
mapshow(xbox,ybox,'DisplayType','polygon','LineStyle','none')
x = [4 4 6 6 8];
y = [2 8 8 2 2];
mapshow(x,y,'Marker','+')
[xi,yi] = polyxpoly(x,y,xbox,ybox);
mapshow(xi,yi,'DisplayType','point','Marker','o')
fprintf("%d \n",xi(1));
fprintf("%d \n",yi(1));