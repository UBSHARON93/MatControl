%1. Find the current location of the vehicle in the global coordinate
%system (xvehicle, yvehicle) (lat,long)
clc;
stateX = 0;
stateY =0;
state.x =0;
state.y =0;
state.v =0;
state.yaw = 0;

lfc = 1;
k = 0.1;
kp = 1;
L = 2.9; %d b/w frontaxle and rear axle
dt = 0.1;  
target_speed = 10.0 / 3.6;
T = 100;
path = [50.555744188142 9.679967612028123;
        50.55580553499353 9.67993810772896;
        50.55583024411951 9.679987728595735;
        50.55584217265845 9.680019915103914;
        50.55585836138502 9.6800534427166;
        50.555802126837214 9.680129885673524;
        ];
   
 X = zeros(1,61);
 Y = zeros(1,61);
 xvalue = zeros(1,6);
 yvalue = zeros(1,6);
 yawvalue = zeros(1,6);
 vvalue = zeros(1,6);
 %Convert lat,long to UTM, ie local coordinate system
 s = 6;
 for c = 1:s  
 [x(c,1),y(c,2),zone(c)] = ll2utm(path(c,1),path(c,2));
 X(c) = x(c,1)-x(1,1)+3;
 Y(c) = y(c,2)-y(1,2)+3;
 %fprintf("X coordiante is %d \n",x(c,1)-x(1,1));
 %fprintf("Y coordiante is %d \n",y(c,2)-y(1,2));
 %fprintf("Zone is %d \n",zone(c));
 end

X = 0:1:60;

for c = 1:60
Y(c) = sin(X(c) / 5.0) * X(c) / 2.0;
end

 lastIndex = length(X)-1;
 time = 0;
 
 target_ind = findMIN(state, X, Y, k, lfc);
        
%2. 2. Find the closest point on the path to the vehicle, (Xcv, Ycv) which is used to locate the vehicle on the path, at which point we can search from it;
%path(1,1) is lat1 path(1,2) is lon1  lat2 path(2,1) lon2 path(2,2)
 %Loop all points in the path and find the closest point using d = sqrt(x**2+y**2)
 i = 1;
 while T >= time && lastIndex > target_ind
        ai = PID(kp,target_speed, state.v);
        %di is delta or steering angle 
        [di, target_ind] = purepursuitcontroller(state, X, Y, target_ind, k, lfc, L);
        fprintf("%f \n",target_ind);
        state = updatestate(state,dt,L, ai, di);
        time = time + dt;

        %fprintf("time: %f State X: %f State Y: %f Yaw: %f \n",time*10, state.x, state.y,state.yaw);
        xvalue(i) = state.x;
        yvalue(i) =state.y;
        i = i+1;
 end

plot(X,Y,xvalue,yvalue);

