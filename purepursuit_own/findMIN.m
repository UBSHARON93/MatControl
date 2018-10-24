function [ind] = findMIN(state, X, Y, k, lfc)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% searches and returns the nearest point index value %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

XI = state.x;
YI = state.y;

 for n=1:6
 d(n) = sqrt((X(n)-XI)^2+(Y(n)-YI)^2);
 end
 
[M,I] = min(d);
ind = I;
L = 0.0;
Lf = k * state.v + lfc;

%search look ahead target point index
while (Lf > L) && ((ind + 1) < length(X))
    dx = X(ind + 1) - X(ind);
    dy = X(ind + 1) - X(ind);
    L = L + sqrt(dx^2 + dy^2);
    ind = ind + 1;
end
    

