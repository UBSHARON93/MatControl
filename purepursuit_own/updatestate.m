function [statex, statey] = updatestate(X, Y, delta)
    statex = X;
    statey = Y;
    statev = 10;
    stateyaw = 0;
    L=2.9;
    dt = 0.1;
    statex = statex + statev * cos(delta) * dt
    statey = statey + statev * sin(delta) * dt
    stateyaw = stateyaw + statev / L * tan(delta) * dt
    dt = dt+1;
end