clc;clear;close all

%% TODO: 
% vraag 3: foutencurves + kijken of het punt k* periode verder weg gelegen is (periodiciteit)
% vraag 4 en 5: parameterkrommes         

%% 1) GEWONE SPLINES
delta = 0.05;
x = -pi:delta:pi; x = x'; 
% evals = -2:0.01:2; evals = evals';
evals = -8:0.01:8; evals = evals'; % meerdere periodes getekend
w = ones(size(evals,1),1);


% Benader cos(x) op [-2,2]

% splines
f = @(x) cos(x); 
% y = periospline(x,f(x),evals);
y = naturalspline(x,f(x),evals);

% veelterminterpolatie
c = kkb2(evals,f(evals),w, 10);

plot(evals,y+0.1);
hold on; plot(evals,f(evals));  %exact function
hold on; plot(evals,polyval(c(end:-1:1),evals)-0.1);
%dit is gezichtsbedrog :), het verschil is niet groter in het midden


% Benader 1/(1+6*x^2) op [-2,2]
figure;
f = @(x) 1./(1+6*x.^2); 

% splines
y = naturalspline(x,f(x),evals);

%veelterminterpolatie
c = kkb2(evals,f(evals),w, 10);

plot(evals,y+0.1);
hold on; plot(evals,f(evals));  %exact function
hold on; plot(evals,polyval(c(end:-1:1),evals)-0.1);


%% 2) PERIODIEKE SPLINES
delta = 0.05;
x = 0:delta:2*pi; x = x'; 
evals = 0:0.01:8*pi; evals = evals'; %getekend over 4 periodes
w = ones(size(evals,1),1);

figure;
f = @(x) sin(x) + cos(4*x)/2;

%splines
y = periospline(x,f(x),evals);

%veelterminterpolatie
c = kkb2(evals,f(evals),w, 10);

plot(evals,y+0.1);
hold on; plot(evals,f(evals));  %exact function
hold on; plot(evals,polyval(c(end:-1:1),evals)-0.1);

% 3) KROMMES BENADEREN
% parametrisatie
% t = linspace(0,1,N)';
% 
% c1 = kkb2(t,x',w,n);
% c2 = kkb2(t,y',w,n);
% 
% figure;
% t = linspace(0,1,10*N);
% plot(polyval(c1(end:-1:1),t),polyval(c2(end:-1:1),t));

