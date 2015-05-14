function y = periospline(x,f,t)
%naturalspline: returns the evalutions in requested points t using natural
%spline approximation
n = length(x) -1;

deltaX = @(k) x(k+1) -x(k);
deltaF = @(k) f(k+1) -f(k);

% create the square matrix, starting from the tridiagonal system for non-periodical spline
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
% now insert new row/column at indices 1 to get the system for periodical
% spline
triDiagonalSystem = [2.*(deltaX(n) + deltaX(1)), deltaX(1), zeros(1,n-3), deltaX(n);
                     deltaX(1),                  triDiagonalSystem(1,:);
                     zeros(n-3,1),               triDiagonalSystem(2:end-1,:);
                     deltaX(n),                  triDiagonalSystem(end,:)];

 
% create the right vector: begin with same vector as non-periodicalspline               
rightVector = zeros(n-1,1);
for i=1:n-1
    rightVector(i,1) = 6*(deltaF(i+1)/deltaX(i+1) - deltaF(i)/deltaX(i));
end
% now insert new element at index 1
rightVector = [6.*(deltaF(1)/deltaX(1) - deltaF(n)/deltaX(n));
               rightVector];

% solve the system           
s = triDiagonalSystem\rightVector; 
s=[s; s(1)];

c1 = f(2:n+1,1)./(deltaX(1:n)) - deltaX(1:n).*s(2:n+1,1)./6;
c2 = f(1:n,1)./(deltaX(1:n)) - (deltaX(1:n)).*s(1:n,1)./6;

% the spline is made up out of functions p_i
p = @(i2,h) ((h-x(i2)).^3.*s(i2+1)-(h-x(i2+1)).^3.*s(i2))./(6.*deltaX(i2)) + c1(i2).*(h-x(i2)) + c2(i2).*(x(i2+1)-h);

y = zeros(length(t),1);
correcty= y;
for i=1:length(t)
    while t(i) > x(end,1)
        t(i) = t(i) - (max(x) - min(x)); %if periodic but not in fundamental interval, search in fundamental interval for corresponding point
    end
    while t(i) < x(1,1)
        t(i) = t(i) + (max(x) - min(x)); %if periodic but not in fundamental interval, search in fundamental interval for corresponding point
    end
    for j = 1:length(x)-1 %zoek het juiste interval 
        if t(i) >= x(j) && t(i) <= x(j+1)
            y(i) = p(j,t(i));
            correcty(i) = sin(t(i));
            break;
        end
    end
end


