clc;
close all;
clear all;
x = [0,8,16,24,32,40];
y = [14.621,11.843,9.870,8.418,7.305,6.413];  %experimental data
%y = [14.6335,11.8564,9.9222,8.4764,7.3954,6.5480];  %data from original eqn; theoritical 
X=27;  %the point at which the interpolating polynomial is to be found

for i=1:length(x)
    
end

%Piecewise Linear Interpolation 
if X<x(1) || X>x(length(x))
    error(['The point should must be in the range.']);
else
    for i=1:length(x)-1
        if X>=x(i) && X<x(i+1)
            Y_pl = Newton(x(i:i+1),y(i:i+1),X);
            break;
        end
    end
end


%Piecewise Quadratic Interpolation 
if X<x(1) || X>x(length(x))
    error(['The point should must be in the range.']);
else
    for i=1:2:length(x)-2
        if X>=x(i) && X<x(i+2)
            Y_pl_2 = Newton(x(i:i+2),y(i:i+2),X)
            break;
        end
    end
end

%Calling functions for calculating the value of interpolation polynomials
%a particular point 
Y = Newton(x,y,X);
L = Lagrange(x,y,X);
P=760; % vapor pressure of oxygen in distilled water
x_new = [0,8,16,24,27,32,40];

%using experimental data 

y_pl = [14.621,11.843,9.870,8.418,Y_pl,7.305,6.413];
y_pl_2 = [14.621,11.843,9.870,8.418,Y_pl_2,7.305,6.413];
y_new_newton = [14.621,11.843,9.870,8.418,Y,7.305,6.413];
y_new_lagrange = [14.621,11.843,9.870,8.418,L,7.305,6.413];

% using theoretical data

% y_new_lagrange = [14.6335, 11.8564,9.9222,8.4764,L, 7.3954,6.5480];
% y_new_newton = [14.6335, 11.8564,9.9222,8.4764,Y, 7.3954,6.5480];
% y_pl = [14.6335, 11.8564,9.9222,8.4764,Y_pl, 7.3954,6.5480];
% y_pl_2 = [14.6335, 11.8564,9.9222,8.4764,Y_pl_2, 7.3954,6.5480];

%Calculating the values of the theoretical values 

for i=1:length(x_new)
    p(i) = 0.61078*exp(17.27*x_new(i)/(x_new(i)+237.3));
end
p = p.*7.50062; %converting to torrs from kPa
DO = []; 

for i=1:length(x_new)
    if(x_new(i)<30)
        DO(i) = ((P-p(i))*0.678)/(35+x_new(i));
    else
        DO(i) = ((P-p(i))*0.827)/(49+x_new(i));
    end
end

%DO;
e_newton=DO-y_new_newton;  %Newton error
e_lagrange = DO - y_new_lagrange; %Lagrange error
e_pl = DO - y_pl; %Piecewise linear error
e_pl_2 = DO - y_pl_2; %Piecewise quadratic error

%Plotting the equations
figure();
p = plot(x_new,DO,'r:',x_new,y_new_newton,'b',x_new,y_new_lagrange,'g',x_new,y_pl,'m',x_new,y_pl_2,'y');
p(1).LineWidth = 1.25;
p(3).LineWidth = 1.25;
hold on;
plot(x_new(5),y_new_newton(5),'r*')
title('Original + Interpolating Polynomials');
legend('Original','Newton', 'Lagrange','Piecewise Linear', 'Piecewise Quadratic')
xlabel('Temp. in Celsius');
ylabel('Dissolved Oxygen in mg/L');

%Plotting the error graphs 
figure();
p2 = plot(x_new,e_newton,'b',x_new,e_lagrange,'g',x_new,e_pl,'c',x_new,e_pl_2,'y');
p2(1).LineWidth = 1.25;
title('Error in the interpolation polynomial');
legend('Newton','Lagrange','Piecewise Linear', 'Piecewise Quadratic');
xlabel('Temp. in Celcius');
ylabel('Error');
