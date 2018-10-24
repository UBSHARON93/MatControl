function [statex, statey, statev, stateyaw] = updatestate(X, Y, dt, L, delta)
    statex = X;
    statey = Y;
    statev = 10;
    stateyaw = 0;
    L=2.9;
    statex = statex + statev * cos(delta) * dt;
    statey = statey + statev * sin(delta) * dt;
    stateyaw = stateyaw + statev / L * tan(delta) * dt;
end