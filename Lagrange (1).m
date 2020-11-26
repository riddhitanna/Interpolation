function v = Lagrange(x, y, p)
x1 = p;
 v = 0;
for i=1:1:length(x)
    L = y(i);
    for j = 1:1:length(x)
        if i~=j
            L = L*((x1 - x(j))/(x(i)-x(j)));
        end
    end
    v = v+L;
end
    
end
