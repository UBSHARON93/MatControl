path = [50.555744188142 9.679967612028123;
        50.55580553499353 9.67993810772896;
        50.55583024411951 9.679987728595735;
        50.55584217265845 9.680019915103914;
        50.55585836138502 9.6800534427166;
        50.555802126837214 9.680129885673524;
        ];
%plot(path(:,1),path(:,2));

x=zeros(6,2);
zone = zeros(1,6);
s = 6;

for c = 1:s  
[x(c,1),x(c,2),zone(c)] = ll2utm(path(c,1),path(c,2));
fprintf("X coordiante is %d \n",x(c,1)-x(1,1));
fprintf("Y coordiante is %d \n",x(c,2)-x(1,2));
fprintf("Zone is %d \n",zone(c));
end

%plot(x(:,1),x(:,2),'b--d','LineWidth',1,'MarkerEdgeColor','red');

fprintf('%d \n',x);


robotCurrentLocation = [0,0];
robotGoal = [x(6,1)-x(1,1),x(6,2)-x(1,2)];
initialOrientation = 0;
robotCurrentPose = [robotCurrentLocation initialOrientation];
robotRadius = 0.4;
robot = ExampleHelperRobotSimulator('emptyMap',2);
robot.enableLaser(false);
robot.setRobotSize(robotRadius);
robot.showTrajectory(true);
robot.setRobotPose(robotCurrentPose);

plot(x(1:6,1)-x(1,1),x(1:6,2)-x(1,2),'k--d')
xlim([0 50])
ylim([0 50])

controller = robotics.PurePursuit;
controller.Waypoints = x;
controller.DesiredLinearVelocity = 0.3;
controller.MaxAngularVelocity = 2;
controller.LookaheadDistance = 0.5;
goalRadius = 0.1;
distanceToGoal = norm(robotCurrentLocation - robotGoal);

controlRate = robotics.Rate(10);
while( distanceToGoal > goalRadius )
    
    % Compute the controller outputs, i.e., the inputs to the robot
    [v, omega] = controller(robot.getRobotPose);
    
    % Simulate the robot using the controller outputs.
    drive(robot, v, omega);
    
    % Extract current location information ([X,Y]) from the current pose of the
    % robot
    robotCurrentPose = robot.getRobotPose;
    
    % Re-compute the distance to the goal
    distanceToGoal = norm(robotCurrentPose(1:2) - robotGoal);
    
    waitfor(controlRate);
    
end 
