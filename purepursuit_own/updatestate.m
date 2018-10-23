function state = updatestate(state, delta):

    state.x = state.x + state.v * cos(requiredheading) * dt
    state.y = state.y + state.v * sin(requiredheading) * dt
    state.yaw = state.yaw + state.v / L * tan(steeringangle) * dt
    state.v = state.v + a * dt
end