%1. Find the current location of the vehicle in the global coordinate
%system (xvehicle, yvehicle) (lat,long)
 path = [50.555744188142 9.679967612028123;
        50.55580553499353 9.67993810772896;
        50.55583024411951 9.679987728595735;
        50.55584217265845 9.680019915103914;
        50.55585836138502 9.6800534427166;
        50.555802126837214 9.680129885673524;
        ];
   
 %Convert lat,long to UTM, ie local coordinate system
 s = 6;
 for c = 1:s  
 [x(c,1),y(c,2),zone(c)] = ll2utm(path(c,1),path(c,2));
 X(c) = x(c,1)-x(1,1);
 Y(c) = y(c,2)-y(1,2);
 %fprintf("X coordiante is %d \n",x(c,1)-x(1,1));
 %fprintf("Y coordiante is %d \n",y(c,2)-y(1,2));
 %fprintf("Zone is %d \n",zone(c));
 end
 %plot(X,Y);
 xx = 0:11.4359;
% yy = interp1(X,Y,xx,'nearest');
 %plot(X, Y);
 XI = [2 6;];

 for n=1:6
 d(n) = sqrt((X(n)-XI(1))^2+(Y(n)-XI(2))^2);
 end
 
 [M,I] = min(d);