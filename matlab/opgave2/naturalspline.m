function y = naturalspline(x,f,t)
%naturalspline: returns the evalutions in requested points using natural
%spline approximation
n = length(x) -1;

triDiagonalSystem = zeros(n-1,n-1);

deltaX = @(k) x(k+1) -x(k);
deltaF = @(k) f(k+1) -f(k);

for i=1:n-1
    triDiagonalSystem(i,i) = 2*(deltaX(i)+ deltaX(i+1));
    if (i ~= 1)
        triDiagonalSystem(i,i-1) = deltaX(i);
    end
    if (i ~= n-1)
        triDiagonalSystem(i,i+1) = deltaX(i+1);
    end
end

rightVector = zeros(n-1,1);
for i=1:n-1
    rightVector(i,1) = 6*(deltaF(i+1)/deltaX(i+1) - deltaF(i)/deltaX(i));
end

s = [0 rightVector\triDiagonalSystem 0]; s = s';

c1 = f(2:n+1,1)./(deltaX(1:n)) - deltaX(1:n).*s(2:n+1,1)./6;
c2 = f(1:n,1)./(deltaX(1:n)) - (deltaX(1:n)).*s(1:n,1)./6;

p = @(i2,h) ((h-x(i2)).^3.*s(i2+1)-(h-x(i2+1)).^3.*s(i2))./(6.*deltaX(i2)) + c1(i2).*(h-x(i2)) + c2(i2).*(x(i2+1)-h);

y = zeros(length(t),1);
for i=1:length(t)
    for j = 1:length(x)-1 %zoek het juiste interval
        if t(i) >= x(j) && t(i) <= x(j+1)
            y(i) = p(j,t(i));
            break;
        end
    end
end


