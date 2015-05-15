close all;clc;clear all;

x = rand(7,1);
y = rand(7,1);
[a,b,c,d,e,f] = ellips(x,y);


%[xAppr,yAppr] = rekenEllipsWaarde(a,b,c,d,e,f,x);
fh = @(x,y) a*x^2 + 2*b*x*y + c*y^2 + d*x + e*y + f;
ezplot(fh,[-2,2])
%plot(real(xAppr),real(yAppr));
error = tekenkegelsnede(a,b,c,d,e,f);
hold on
scatter(x,y);
error


