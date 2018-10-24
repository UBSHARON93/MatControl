function [delta, ind] = purepursuitcontroller(state, cx, cy, pind, k, lfc)
    ind = findMIN(state, X, Y, k, lfc);

    if pind >= ind
        ind = pind;
    end
    if ind < length(cx)
        tx = cx(ind);
        ty = cy(ind);
    else
        tx = cx(-1);
        ty = cy(-1);
        ind = len(cx) - 1;
    end

    alpha = atan2(ty - state.y, tx - state.x) - state.yaw;

    if state.v < 0 
       alpha = math.pi - alpha;
    end
    
    Lf = k * state.v + Lfc;
    delta = math.atan2(2.0 * L *sin(alpha) / Lf, 1.0);

    end