function hw3_show(A)
%This function runs an optimization algorithm by minimising the error value
%from compute_err.m, and plots the variation in metabolite concentration
%with time.

%Perform optimization with fminsearchbnd algorithm.
[X,FVAL] = fminsearchbnd(@(x) compute_err(A,x),[0;0;0],[0;0;0],[10;10;10]);

%Displaying the results
fprintf('Parameter values: \n');
disp(X);
fprintf('Value of cost function for the above parameter set: \n');
disp(FVAL);

%To get the predicted value of metabolite concentrations.
[E,x_values] = compute_err(A,X);
[m,n]=size(x_values);
% size of x_values is 75*8
t(:) = A(:,1)';
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