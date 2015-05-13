function kromme
clc;clear;close all

[x,y]= click; x=x';y=y';%x = [x x(1)]'; y = [y y(1)]'; %gesloten curve: x_n = x_0 en y_n = y_0
N = length(x)
% use as t the Pythagorean distances between successive points
% t = [sqrt( (x(1:end-1)-x(2:end)).^2 + ...
%           (y(1:end-1)-y(2:end)).^2); 0]; %the last element is the same as the first element, so its corresponding t is 0.
t = linspace(0,1,N)'
w = ones(size(x'));
evals = linspace(0,1,10*N); 

% n =6;
% c1 = kkb2(t,x,w,n);
% c2 = kkb2(t,y,w,n);
% plot(polyval(c1(end:-1:1),t),polyval(c2(end:-1:1),t));
% axis([0 1 0 1])

% figure;
    

%% I have no idea why it is not smooth as a spline should be. For some reason, 10*N smoothes the curve a bit. 

c1 = periospline(t,x,evals)
c2 = periospline(t,y,evals)

plot(c1,c2);
axis([0 1 0 1]);

      
      