function [a,b,c,d,e,f] = cirkel(x,y)
%cirkel Geeft de coordinaten van de cirkel die de meetpunten x en y
%benadert
%  x en y zijn kolomvectoren, a..f zijn de coefficienten van ax^2 + 2bxy + cy^2 + dx + ey + f = 0 

columnOfOnes = ones(size(x,1),1);

A = [x, y, columnOfOnes];   %A * coef = -x_i^2 - y_i^2  % coef is vector met coefficienten (d,e,f)
b = -y.*y-x.*x;
x = A\b;
a = 1;
c = 1;
b = 0;
d = x(1);
e = x(2);
f = x(3);
end