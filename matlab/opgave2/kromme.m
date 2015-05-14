function kromme
clc;clear;close all

[x,y]= click; x=x';y=y';%x = [x x(1)]'; y = [y y(1)]'; %gesloten curve: x_n = x_0 en y_n = y_0
N = length(x)
% use as t the length of the broken line that connects successive points up
% to point i
t = zeros(N, 1);
for i=2:N
    arc_length = sqrt((x(i)-x(i-1))^2 + (y(i)-y(i-1))^2); 
    t(i) = t(i-1) + arc_length; 
end
t=t./t(length(t)); %herschalen naar [0,1]

w = ones(size(x'));
evals = linspace(0,1,10*N);

% n =40;
% c1 = kkb1(t,x,w,n);
% c2 = kkb1(t,y,w,n);
% 
% 
% plot(polyval(c1(end:-1:1),evals),polyval(c2(end:-1:1),evals));
% axis([0 1 0 1])

% figure;
%% I have no idea why it is not smooth as a spline should be. The splines seem to interpolate linearily instead of cubically
c1 = naturalspline(t,x,evals);
c2 = naturalspline(t,y,evals);

% plot(c1,c2);

% Comparison with results using the MATLAB spline function
c1_mat = spline(t',x',evals');
c2_mat = spline(t',y',evals');

plot(c1,c2,c1_mat',c2_mat',x,y);
legend('mine','matlab','chosen points')
axis([0 1 0 1]);

      
      