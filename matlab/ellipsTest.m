close all;clc;clear all;

x = rand(5,1);
y = rand(5,1);
[a,b,c,d,e,f] = ellips(x,y);


error = tekenkegelsnede(a,b,c,d,e,f);
hold on
scatter(x,y);
error


