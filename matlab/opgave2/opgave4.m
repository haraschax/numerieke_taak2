[x,y] = click;
N = size(x,2);

% parametrisatie
t = linspace(0,1,N)'
% t = [sqrt( (x(1:end-1)-x(2:end)).^2 + ...
%           (y(1:end-1)-y(2:end)).^2), 0]; t = t'; %the last element is the same as the first element, so its corresponding t is 0.

% gewichten
w = ones(size(x'));

% graad benadering
n = 6;

% kleinste-kwadratenbenaderingen
c1 = kkb2(t,x',w,n);
c2 = kkb2(t,y',w,n);

% controle
figure;
t = linspace(0,1,10*N);
plot(polyval(c1(end:-1:1),t),polyval(c2(end:-1:1),t));
axis([0 1 0 1]);
