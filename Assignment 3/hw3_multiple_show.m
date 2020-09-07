function hw3_multiple_show(A,B)
%This function runs an optimization algorithm by minimising the error value
%from multiple_compute_err.m, and plots the variation in metabolite concentration
%with time.

%Perform optimization with fminsearchbnd algorithm.
[X,FVAL] = fminsearchbnd(@(x) multiple_compute_err(A,B,x),[1;1;1],[0;0;0],[10;10;10]);

%Displaying the results
fprintf('Parameter values: \n');
disp(X);
fprintf('Value of cost function for the above parameter set: \n');
disp(FVAL);

%To get the predicted value of metabolite concentrations.
[E,x_values] = multiple_compute_err(A,B,X);
[m,n]=size(x_values);
% size of x_values is 75*8
t(:) = A(:,1)'; %one can take it either from A or B. It doesn't matter.
% size of t is 75*1

%Plotting the metabolite concentration (all 8 of them) with time.
fprintf('Displaying the variation in the metabolites: \n\n');

figure;
for i = 1:n
    plot(t,x_values(:,i));
    hold on;
end
title('Metabolite concentration');
xlabel('Time (in seconds)');
ylabel('Concentration (given units)');
end