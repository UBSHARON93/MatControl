A = rand(1,2);
B = rand(10,2);
xq1 = -3:.01:3;
v1 = spline(B(:,1),B(:,2),xq1);
v = pchip(B(:,1),B(:,2),xq1);
plot(v);
plot(v1);

%compute Euclidean distances:
distances = sqrt(sum(bsxfun(@minus, B, A).^2,2));

%find the smallest distance and use that as an index into B:
closest = B(find(distances==min(distances)),:);
