% Sampling
close all;
clear all; 
clc;

% Basic declarations
Fi = 100;    % Initial frequency
Ti = 1/Fi;  % Initial period
L = 1000;    % Length of signal
P = 4;      % Number of periods
K = 6;      % Sampling factor

% Define signal function
tmin = 0;
tmax = P*Ti;
t = linspace(tmin,tmax,L);
ya = sin(2*pi*Fi*t);

% Sampling
Fs = K*Fi;
Ts = 1/Fs;
fk = Fi/Fs;
nmin = ceil(tmin/Ts);
nmax = floor(tmax/Ts);
n = nmin:nmax;
yd = sin(2*pi*fk*n);

% Plot
plot(t,ya);         % Original signal
hold on;
plot(Ts*n,yd, '*r') % Sampling
stem(Ts*n, yd);