clc;clear;close all

%% TODO: vraag 3: foutencurves       
%% General variables: evaluation points, graphs stuff etc...

% voor de splinebenadering
delta = 0.2;%distance between successive spline-node points is 0.5
x=  linspace(-pi,pi,2*pi/delta)'; % voor meer dan 1 periode gebruik je best periospline

%voor alle benaderingen
start = -10; ending = 10;
% start = -2; ending = 2;
evaldelta = 0.01;            % afstand tussen opeenvolgende evaluatiepunten
evals = linspace(start,ending,(ending-start)/evaldelta); evals = evals';
graph_offset = 0.01;         % om grafieken van elkaar te kunnen onderscheiden
polynomial_degree = 10;      % graad van de interpolerende veelterm

%% 1) GEWONE SPLINES
% Benader cos(x) op [-2,2]

% splines
f = @(x) cos(x); 
% y = periospline(x,f(x),evals);
y = naturalspline(x,f(x),evals);

% veelterminterpolatie
interPoints = linspace(-2,2,4/delta)'; w = ones(size(interPoints,1),1); %de veelterm wordt enkel geïnterpoleerd op het interval, niet erbuiten. Dat zou ervoor zorgen dat hij nog veel slechter is
c = kkb1(interPoints,f(interPoints),w, polynomial_degree);

plot(evals,y+graph_offset);
hold on; plot(evals,f(evals));  % exact function
hold on; plot(evals,polyval(c(end:-1:1),evals)-graph_offset);
legend('spline','exact','polynomial')
f(evals)
axis([start ending min(f(evals))-0.1-graph_offset max(f(evals))+0.1+graph_offset])
% dit is gezichtsbedrog :), het verschil is niét groter in het midden


% Benader 1/(1+6*x^2) op [-2,2]
start = -3; ending = 3;
evals = linspace(start,ending,(ending-start)/evaldelta); evals = evals';
figure;
f = @(x) 1./(1+6*x.^2); 

% splines
y = naturalspline(x,f(x),evals);

%veelterminterpolatie
c = kkb1(interPoints,f(interPoints),w, polynomial_degree);

plot(evals,y+graph_offset);
hold on; plot(evals,f(evals));  % exact function
hold on; plot(evals,polyval(c(end:-1:1),evals)-graph_offset);
legend('spline','exact','polynomial')
axis([start ending min(f(evals))-0.1-graph_offset max(f(evals))+0.1+graph_offset])



%% 2) PERIODIEKE SPLINES
x=  linspace(0,2*pi,2*pi/delta)';
start = 0; ending= 8*pi;            % teken 4 periodes
evals = linspace(start,ending,(ending-start)/evaldelta); evals = evals'; 

figure;
f = @(x) sin(x) + cos(4*x)/2;

%splines
y = periospline(x,f(x),evals);

%veelterminterpolatie
interPoints = linspace(0,4,4/delta)'; w = ones(size(interPoints,1),1);
c = kkb1(interPoints,f(interPoints),w, polynomial_degree);

plot(evals,y+graph_offset);
hold on; plot(evals,f(evals));  %exact function
hold on; plot(evals,polyval(c(end:-1:1),evals)-graph_offset);
legend('spline','exact','polynomial')
axis([start ending min(f(evals))-0.1-graph_offset max(f(evals))+0.1+graph_offset])

%% 3) KROMMES BENADEREN

% zie kromme.m

