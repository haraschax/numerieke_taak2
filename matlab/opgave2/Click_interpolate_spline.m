[x,y]= click; x=x';y=y';
N = length(x);
evals = linspace(0,1,1000*N);

c1 = naturalspline(x,y,evals);
% c1 = spline(x',y',evals');
plot(evals,c1);
axis([0 1 0 1]);