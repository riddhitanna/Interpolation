function [f] = Newton(x,y,p)
    D = zeros(length(x),length(x)); % array for storing the divided differences
    D(:,1) = y;
    for j= 2:length(x)
        for i = 1: length(x)+1-j
            D(i,j) = (D(i+1,j-1)-D(i,j-1))/(x(i+j-1)-x(i));
        end
    end
    D
    C = D(1,:);
    C_sum = C(1);
    for j = 2:length(x)
        x_mult = C(j);
        for k = 1:j-1
            x_mult = x_mult * (p-x(k));
        end
    C_sum = C_sum + x_mult;
    end
    
    f = C_sum;
end