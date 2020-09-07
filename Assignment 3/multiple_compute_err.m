function [E,x_pred] = multiple_compute_err(D,B,k)
% input - 
%D - Dataset - metabolite concentration in different time points
%k = parameter set - in the order p1, p2, p3
%This function takes computes the error between the predicted data (using
%ode23s solver) and the measured data from 2 sets, for a given set of parameter values.

global p1 p2 p3;
p1 = k(1);
p2 = k(2);
p3 = k(3);
l = length(D(:,2)); %Number of data points available for each metabolite
total_time = D(l,1); %The final time point as per the measured data.

%Dataset1
x = zeros(l,8); %A matrix is created to store the measured metabolite concentration from dataset1

x(:,1) = D(:,2)'; %MKKK
x(:,2) = D(:,3)'; %MKKK-P
x(:,3) = D(:,4)'; %MKK
x(:,4) = D(:,5)'; %MKK-P
x(:,5) = D(:,6)'; %MKK-PP
x(:,6) = D(:,7)'; %MAPK
x(:,7) = D(:,8)'; %MAPK-P
x(:,8) = D(:,9)'; %MAPK-PP

%Dataset2
y = zeros(l,8); %A matrix is created to store the measured metabolite concentration from dataset2

y(:,1) = B(:,2)'; %MKKK
y(:,2) = B(:,3)'; %MKKK-P
y(:,3) = B(:,4)'; %MKK
y(:,4) = B(:,5)'; %MKK-P
y(:,5) = B(:,6)'; %MKK-PP
y(:,6) = B(:,7)'; %MAPK
y(:,7) = B(:,8)'; %MAPK-P
y(:,8) = B(:,9)'; %MAPK-PP

x0=zeros(8,1); %Initial conditions as given in the question statement

x0(1) = 90.0; %MKKK
x0(2) = 10.0;%MKKK_P
x0(3) = 280.0; %MKK
x0(4) = 10.0; %MKK_P
x0(5) = 10.0; %MKK_PP
x0(6) = 280.0; %MAPK
x0(7) = 10.0; %MAPK_P
x0(8) = 10.0; %MAPK_PP

tspan= linspace(0,total_time,l);  %The split in time points match that of the measured data
[t_pred,x_pred]=ode23s(@ode_analyser,tspan,x0);

[m,n]=size(x_pred);
%x_pred is an array of size 75*8 in this case.

E=0; %error value
%Cost/Error function is calculated as a sum of squared errors for both the data sets.
for i=1:n
    for j=1:m
        if ~isnan(x(j,i))&& ~isnan(y(j,i))
            a = x(j,i);
            c = y(j,i);
            b = x_pred(j,i);
            E=E+((b - a)^2) + ((b - c)^2);
        end
    end
end
end