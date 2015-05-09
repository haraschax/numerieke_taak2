function [a,b,c,d,e,f] = cirkel(x,y)
%cirkel Geeft de coordinaten van de cirkel die de meetpunten x en y
%benadert
%  x en y zijn kolomvectoren, a..f zijn de coefficienten van ax^2 + 2bxy + cy^2 + dx + ey + f = 0 


columnOfOnes = ones(size(x,1),1);

A = [2*x.*y, y.*y - x.*x, x, y, columnOfOnes]
b = -x.*x;
x = A\b;
b = x(1);
c = x(2);
d = x(3);
e = x(4);
f = x(5);
a = 1-c;
end