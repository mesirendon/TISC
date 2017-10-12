% Function processing 
close all; 
clear all;
clc;

% Basic declarations
Fi = 60;       % Initial frequency
Ti = 1/Fi;       % Initial period
L = 1500;        % Length of signal
G = 1;          % Func analysis
P = 2 * G;       % Number of periods
K = 3/G;           % Sampling factor

% Define signal function
tmin = 0;
tmax = P*Ti;
t = linspace(tmin,tmax,L);
signal = sin(2*pi*Fi*t);

% Sampling
Fs = K*Fi;
Ts = 1/Fs;
fk = Fi/Fs;   % fk = 1/K
nmin = ceil(tmin/Ts); 
nmax = floor(tmax/Ts);
n = nmin:nmax;
yd = sin(2*pi*fk*n);

% Fast Fourier transform
Y = fft(signal);
f = (0:length(Y)-1)*250/length(Y);

% Haar transform
t2 = linspace(tmin,tmax/2,L/2);
trend = linspace(0,0,L/2);
j = 1;
for i=1:2:L
  trend(j) = sqrt(2)*(signal(i)+signal(i+1)); % First iteration: Trend
  j = j+1;
end

fluc = linspace(0,0,L/2);
j = 1;
for i=1:2:L
  fluc(j) = sqrt(2)*(signal(i)-signal(i+1));  % First iteration: Fluctuation
  j = j+1;
end

t3 = linspace(tmin,tmax/4,L/4);
haar = linspace(0,0,L/4);
j = 1;
for i=1:2:L/2  
  haar(j) = sqrt(2)*(trend(i)+trend(i+1));    % Second iteration: Haar transform
  j = j+1;
end

% Plots
fig1 = figure; set(fig1,'name','Sampling and Fourier transform')
subplot(211);
hold on;
plot(t,signal);                 % Original signal
plot(Ts*n,yd, '*r')             % Sampling
hold off;
title('Signal function with sampling')
ylabel('Signal')
xlabel('t(s)')

subplot(212);
plot(f, abs(Y));       % Fourier
title('Fast Fourier transform')
ylabel('Amplitud of signal')
xlabel('f(Hz)')

%fig2 = figure; set(fig2,'name','Haar transform')
%subplot(411); plot(t,signal);   % Signal function
%title('Signal function')
%ylabel('Signal')
%xlabel('t(s)')
%
%subplot(412); plot(t2,trend);   % Trend
%title('Trend')
%ylabel('Signal')
%xlabel('t(s)')
%
%subplot(413); plot(t2,fluc);    % Fluctuation
%title('Fluctuation')
%ylabel('Signal')
%xlabel('t(s)')
%
%subplot(414); plot(t3,haar);    % Haar transform
%title('Haar transform')
%ylabel('Signal')
%xlabel('t(s)')