delta = 0.1;
x = -pi:delta:pi; x = x'; 
% evals = -2:0.01:2; evals = evals';
evals = -8:0.01:8; evals = evals'; % meerdere periodes getekend
w = ones(size(evals,1),1);


% Benader cos(x) op [-2,2]

% splines
f = @(x) cos(x); 
% y = periospline(x,f(x),evals);
y = naturalspline(x,f(x),evals);
y2 = interp1(x',f(x)',evals');

% veelterminterpolatie
c = kkb2(evals,f(evals),w, 10);

plot(evals,y);
hold on;
plot(evals, y2)