close all;clc;clear all;

x = rand(6,1);
y = rand(6,1);
[a,b,c,d,e,f] = cirkel(x,y);


%[xAppr,yAppr] = rekenEllipsWaarde(a,b,c,d,e,f,x);
%plot(real(xAppr),real(yAppr));

%bereken de functiewaarden met de interpolerende_cirkel - forumule
fh = @(x,y) a*x^2 + 2*b*x*y + c*y^2 + d*x + e*y + f;

%plot de interpolerende cirkel en de gekozen punten
ezplot(fh,[-2,2])
hold on
scatter(x,y);


