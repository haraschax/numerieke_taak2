clc;clear;close all

%% TODO: vraag 3: foutencurves       
%% General variables: evaluation points, graphs stuff etc...

% voor de splinebenadering
N = 5;%distance between successive spline-node points is 0.5
x=  linspace(-pi,pi,N)'; % voor meer dan 1 periode gebruik je best periospline

%voor alle benaderingen
% start = -10; ending = 10;
start = -2; ending = 2;
evaldelta = 0.01;            % afstand tussen opeenvolgende evaluatiepunten
evals = linspace(start,ending,(ending-start)/evaldelta); evals = evals';
graph_offset = 0.0;         % om grafieken van elkaar te kunnen onderscheiden
polynomial_degree = 2;      % graad van de interpolerende veelterm

%% 1) GEWONE SPLINES
% Benader cos(x) op [-2,2]

% splines
f = @(x) cos(x); 
% y = periospline(x,f(x),evals);
y = naturalspline(x,f(x),evals);

% veelterminterpolatie
interPoints = linspace(-2,2,N)'; w = ones(size(interPoints,1),1); %de veelterm wordt enkel geïnterpoleerd op het interval, niet erbuiten. Dat zou ervoor zorgen dat hij nog veel slechter is
c = kkb1(interPoints,f(interPoints),w, polynomial_degree);

plot(evals,y+graph_offset);
hold on; plot(evals,f(evals));  % exact function
hold on; plot(evals,polyval(c(end:-1:1),evals)-graph_offset);
legend({'spline','exact','polynomial'},'FontSize',15)
f(evals)
axis([start ending min(f(evals))-0.1-graph_offset max(f(evals))+0.1+graph_offset])
% dit is gezichtsbedrog :), het verschil is niét groter in het midden


N = 15;
x=  linspace(-2,2,N)';
% Benader 1/(1+6*x^2) op [-2,2]
start = -2; ending = 2;
evals = linspace(start,ending,(ending-start)/evaldelta); evals = evals';
polynomial_degree = 10; 
figure;
f = @(x) 1./(1+6*x.^2); 

% splines
y = naturalspline(x,f(x),evals);

%veelterminterpolatie
interPoints = linspace(-2,2,N)'; w = ones(size(interPoints,1),1); %de veelterm wordt enkel geïnterpoleerd op het interval, niet erbuiten. Dat zou ervoor zorgen dat hij nog veel slechter is
c = kkb1(interPoints,f(interPoints),w, polynomial_degree);

plot(evals,y+graph_offset);
hold on; plot(evals,f(evals));  % exact function
hold on; plot(evals,polyval(c(end:-1:1),evals)-graph_offset);
legend({'spline','exact','polynomial'},'FontSize',15)

axis([start ending min(f(evals))-0.1-graph_offset max(f(evals))+0.1+graph_offset])


close all;
%% 2) PERIODIEKE SPLINES
max_error=zeros(100,1);
max_error_poly=max_error;

for n=4:100
    N = n;
    x=  linspace(0,2*pi,N)';
    start = 0; ending= 2*pi;
    evals = linspace(start,ending,(ending-start)/evaldelta); evals = evals';
    polynomial_degree = 10;
    
    figure;
    f = @(x) sin(x) + cos(4*x)/2;
    
    %splines
    y = periospline(x,f(x),evals);
    
    %veelterminterpolatie
    interPoints = linspace(0,2*pi,N)'; w = ones(size(interPoints,1),1);
    c = kkb1(interPoints,f(interPoints),w, polynomial_degree);
    polyEvals = polyval(c(end:-1:1),evals);
    
    max_error(n-3,:) = max(abs(y-f(evals)));
    max_error_poly(n-3,:) = max(abs(polyEvals-f(evals)));
    
%     plot(evals,y+graph_offset);
%     hold on; plot(evals,f(evals));  %exact function
%     hold on; plot(evals,polyval(c(end:-1:1),evals)-graph_offset);
%     legend({'spline','exact','polynomial'},'FontSize',15)
%     axis([start ending min(f(evals))-0.1-graph_offset max(f(evals))+0.1+graph_offset])
    
    % figure;
    % plot(0.01:0.01:6.28,f(evals)' - y', 0.01:0.01:6.28, f(evals) - polyval(c(end:-1:1),evals))
    % legend({'splineError', 'polyError'}, 'FOntSize', 15)
end
close all;
semilogy(4:length(max_error), max_error(1:100-3), 4:length(max_error_poly), max_error_poly(1:100-3))
legend({'splineError', 'polyError'},'FontSize',15) 
%% 3) KROMMES BENADEREN

% zie kromme.m

