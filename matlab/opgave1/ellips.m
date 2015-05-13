function [a,b,c,d,e,f] = ellips(x,y)
%ellips Geeft de coordinaten van de ellips die de meetpunten x en y
%benadert
%  x en y zijn kolomvectoren, a..f zijn de coefficienten van ax^2 + 2bxy + cy^2 + dx + ey + f = 0 


columnOfOnes = ones(size(x,1),1);

<<<<<<< HEAD
A = [2*x.*y, y.*y - x.*x, x, y, columnOfOnes]; %A * coef = -x^2  % coef is vector met coefficienten (b,c,d,e,f)
=======
A = [2*x.*y, y.*y - x.*x, x, y, columnOfOnes];
>>>>>>> a6dae6ba7b45c7b3fc4fad1a3d480ac26f6782c2
b = -x.*x;
x = A\b;

b = x(1);
c = x(2);
d = x(3);
e = x(4);
f = x(5);
a = 1-c;
end

