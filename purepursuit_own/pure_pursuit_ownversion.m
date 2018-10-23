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


%2. 2. Find the closest point on the path to the vehicle, (Xcv, Ycv) which is used to locate the vehicle on the path, at which point we can search from it;
%path(1,1) is lat1 path(1,2) is lon1  lat2 path(2,1) lon2 path(2,2)
 %Loop all points in the path and find the closest point using d = sqrt(x**2+y**2)
 n = 6;
 for c = 1:n-1 
 lat1 = path(c,1); lat2 = path(c+1,1);
 lon1 = path(c,2); lon2 = path(c+1,2);
 gpsheading = atan2( sin(lon2-lon1)*cos(lat2), cos(lat1)*sin(lat2) - sin(lat1)*cos(lat2)*cos(lon2-lon1)); %LAT,LONG
 %gpsheading2 = atan2( Y2-Y1, X2-X1); %UTM
 vehicleheading = 0;
 requiredheading = gpsheading - vehicleheading;
 
 %goalpointx = goalpointx + v*cos(requiredheading)*dt
 %goalpointy = goalpointy + v*sin(requiredheading)*dt
 %3. Choosing a constant look-ahead distance and thensearch the goal point (Xla,Yla);
 lookaheaddistance = 10;
 L= 10; %d b/w frontaxle and rear axle
 %4. Transform the goal point to vehicle coordinates(xla,yla);

    %find the last pont on the path and convert it to UTM

%5. Calculate the curvature and then acquire the steering angle from Equation (1);
 k = (2*sin(requiredheading))/lookaheaddistance; %curvature
 steeringangle = atan(k*L);
 end



%6. Update the vehicle's position.
updatestate(X, Y, delta);
