%We use ode23 here :P

global a b;
a = 20;
b = 2;
c = 5;

tlast = 4;

x0 = c;
[t,x] = ode23s(@derivative,[0,tlast],x0);

figure;
plot(t,x,'r')
hold on