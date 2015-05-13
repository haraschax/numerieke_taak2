close all;clc;clear all;

x = rand(5,1);
y = rand(5,1);
[a,b,c,d,e,f] = ellips(x,y);


<<<<<<< HEAD
%[xAppr,yAppr] = rekenEllipsWaarde(a,b,c,d,e,f,x);
fh = @(x,y) a*x^2 + 2*b*x*y + c*y^2 + d*x + e*y + f;
ezplot(fh,[-2,2])
%plot(real(xAppr),real(yAppr));
=======
error = tekenkegelsnede(a,b,c,d,e,f);
>>>>>>> a6dae6ba7b45c7b3fc4fad1a3d480ac26f6782c2
hold on
scatter(x,y);
error


