%Write a function t perform basic operations(+,-,*,/,.*,./) on 2 given matrices.
%Also check the compatibility of matrix dimensions and throw error.

function[] = Tutorial1(A,B,k)
    [a,b]=size(A);
    [c,d]=size(B);
    if size(A)==size(B)
        fprintf('Sum = ');
        A+B
        fprintf('Difference = ');
        A-B
    else
        error('They are not of same size');
    end
    if b==c
        fprintf('Product = ');
        A*B
    else
        error('Cannot multiple these matrices.');
    end
    if det(B)~=0
        fprintf('Division = ');
        A/B
    else
        error('Cannot divide (implicit) these matrices.');
    end
    fprintf('Dot multiplication and division of A matrix = ');
    disp(A.*k)
    disp(A./k)

%% Plot the function y1=sin(x) anf y2=cos(x) on a single graph

x=linspace(-pi,pi);
a = sin(x);
b = cos(x);
figure;
plot(x,a,'*');
hold on;
plot(x,b,'.');

%% Plot the function y in the interval x=[-10,10] with 20 points

x = linspace(-10,10,20);
y = (1-2*x+3*(x.^2))./(1+2*x+3*(x.^2));

figure;
plot(x,y);
end