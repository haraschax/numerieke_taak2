function y = periospline(x,f,t)
%naturalspline: returns the evalutions in requested points t using natural
%spline approximation
n = length(x) -1;

deltaX = @(k) x(k+1) -x(k);
deltaF = @(k) f(k+1) -f(k);

% System: begin with same matrix as non-periodicalspline
triDiagonalSystem = zeros(n-1,n-1);
for i=1:n-1
    triDiagonalSystem(i,i) = 2*(deltaX(i)+ deltaX(i+1));
    if (i ~= 1)
        triDiagonalSystem(i,i-1) = deltaX(i);
    end
    if (i ~= n-1)
        triDiagonalSystem(i,i+1) = deltaX(i+1);
    end
end

% now insert new row/column at indices 1
triDiagonalSystem = [2.*(deltaX(n) + deltaX(1)), deltaX(1), zeros(1,n-3), deltaX(n);
                     deltaX(1),                  triDiagonalSystem(1,:);
                     zeros(n-3,1),               triDiagonalSystem(2:end-1,:);
                     deltaX(n),                  triDiagonalSystem(end,:)];

 
% Right Vector: begin with same matrix as non-periodicalspline               
rightVector = zeros(n-1,1);
for i=1:n-1
    rightVector(i,1) = 6*(deltaF(i+1)/deltaX(i+1) - deltaF(i)/deltaX(i));
end
% now insert new element at index 1
rightVector = [6.*(deltaF(1)/deltaX(1) - deltaF(n)/deltaX(n));
               rightVector];

s = rightVector\triDiagonalSystem; s = [s, s(1)];s = s';

c1 = f(2:n+1,1)./(deltaX(1:n)) - deltaX(1:n).*s(2:n+1,1)./6;
c2 = f(1:n,1)./(deltaX(1:n)) - (deltaX(1:n)).*s(1:n,1)./6;

p = @(i2,h) ((h-x(i2)).^3.*s(i2+1)-(h-x(i2+1)).^3.*s(i2))./(6.*deltaX(i2)) + c1(i2).*(h-x(i2)) + c2(i2).*(x(i2+1)-h);

y = zeros(length(t),1);
correcty= y;
for i=1:length(t)
    while t(i) >= x(end,1)
        t(i) = t(i) - (max(x) - min(x)); %if periodic but not in fundamental interval, search in fundamental interval for corresponding point
    end
    while t(i) <= x(1,1)
        t(i) = t(i) + (max(x) - min(x)); %if periodic but not in fundamental interval, search in fundamental interval for corresponding point
    end
    for j = 1:length(x)-1 %zoek het juiste interval 
        %% TODO moeten we hier ook kijken of het punt k* periode verder weg gelegen is? nu geven we enkel waarden als het binnen het opgestelde spline-interval is, 'periodieke' splines lijken dan nogal nutteloos
        if t(i) >= x(j) && t(i) <= x(j+1)
            y(i) = p(j,t(i));
            correcty(i) = sin(t(i));
            break;
        end
    end
end


