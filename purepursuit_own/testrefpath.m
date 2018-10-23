for k = 1:20 
 xref(k) = sin(k-1)/10;
 yref(k) = 20*(k-1)/100;
end
plot(xref,yref,'b--d','LineWidth',1,'MarkerEdgeColor','red');