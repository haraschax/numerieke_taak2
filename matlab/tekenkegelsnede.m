function [err] = tekenkegelsnede(a,b,c,d,e,f)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

A = [a b; b c];
B = [d;e];
T = (-0.5*B')/A;
T = T';
cStreep = T'*A*T + B'*T + f;

err = 1;
eigOfA = eig(A);

if (cStreep <= 0 && eigOfA(1) > 0 && eigOfA(2) > 0)
    fh = @(x,y) a*x^2 + 2*b*x*y + c*y^2 + d*x + e*y + f;
    ezplot(fh,[-1,1]);
    err = 0;
end


end

