function xdot = ode_analyser(t,x)
%This function has all the parameter values, reaction equations and the
%rate of change of all the metabolites.
global p1 p2 p3;

%Set 1 parameter values
Ki = 9;
n=1;
V1 = 2.5;
[V9,V10]=deal(0.5);
K1 = 10;
K2 = 8;
[K3,K4,K5,K6,K7,K8,K9,K10]= deal(15);

%Set 2 parameter values
% Ki = 18;
% n=2;
% V1 = 2.5;
% [V9,V10]=deal(1.25);
% K1 = 50;
% K2 = 40;
% [K3,K4,K5,K6,K7,K8,K9,K10]= deal(100);

%Reactions
r1 =V1*x(1)/((1+(x(8)/Ki)^n)*(K1+x(1)));
r2 = p3*x(2)/(K2+x(2));
r3 = p1*x(2)*x(3)/(K3+x(3));
r4 = p1*x(2)*x(4)/(K4+x(4));
r5 = p2*x(5)/(K5+x(5));
r6 = p2*x(4)/(K6+x(4));
r7 = p1*x(5)*x(6)/(K7+x(6));
r8 = p1*x(5)*x(7)/(K8+x(7));
r9 = V9*x(8)/(K9+x(8));
r10 = V10*x(7)/(K10+x(7));

%d[metabolite]/dt of every metabolite in the cell
xdot=zeros(8,1);
%d[MKKK]/dt
xdot(1) = (-1.0 * r1) + ( 1.0 * r2);
%d[MKKK_P]/dt
xdot(2) = ( 1.0 * r1) + (-1.0 * r2);
%d[MKK]/dt	
xdot(3) = (-1.0 * r3) + ( 1.0 * r6);
%d[MKK_P]/dt
xdot(4) = ( 1.0 * r3) + (-1.0 * r4) + ( 1.0 * r5) + (-1.0 * r6);
%d[MKK_PP]/dt	
xdot(5) = ( 1.0 * r4) + (-1.0 * r5);
%d[MAPK]/dt
xdot(6) = (-1.0 * r7) + ( 1.0 * r10);
%d[MAPK_P]/dt	
xdot(7) = ( 1.0 * r7) + (-1.0 * r8) + ( 1.0 * r9) + (-1.0 * r10);
%d[MAPK_PP]/dt	
xdot(8) = ( 1.0 * r8) + (-1.0 * r9);

end
