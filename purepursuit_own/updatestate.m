function [state] = updatestate(state, dt, L, a, delta)
    state.x = state.x + state.v * cos(state.yaw) * dt;
    state.y = state.y + state.v * sin(state.yaw) * dt;
    state.yaw = state.yaw + state.v / L * tan(delta) * dt;
    %fprintf("%f \n",tan(delta));
    state.v = state.v + a * dt;
end

