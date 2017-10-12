% Audio processing
clear all;
close all;
clc;

% Basic declarations
Fs = 44100; % Sampling frequency
T = 1/Fs;   % Sampling period

% Record audio
audio = audiorecorder(Fs,16,1);
recordblocking(audio, 5);

% Play audio
play(audio);
signal = getaudiodata(audio);

%first_audio = 'recorded-audio-01.ogg';
%audiowrite(first_audio,signal,Fs);

% Signal
L = length(signal);   % Length of signal
t = (0:L-1)*T;        % Time vector

% Fast Fourier transform
Y = fft(signal);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;

% Haar transform
t2 = (0:L/2-1)*T;
trend = (0:(L/2)-1);
j = 1;
for i=1:2:L
  trend(j) = sqrt(2)*(signal(i)+signal(i+1)); % First iteration: Trend
  j = j+1;
end

fluc = (0:(L/2)-1);
j = 1;
for i=1:2:L
  fluc(j) = sqrt(2)*(signal(i)-signal(i+1));  % First iteration: Fluctuation
  j = j+1;
end

t3 = (0:L/4-1)*T;
haar = (0:(L/4)-1)*T;
j = 1;
for i=1:2:L/2   
  haar(j) = sqrt(2)*(trend(i)+trend(i+1));    % Second iteration: Haar transform
  j = j+1;
end

% Plots
fig1 = figure; set(fig1,'name','Fourier transform')
subplot(211); plot(t,signal); % Recorded signal
title('Recorded signal')
ylabel('Signal')
xlabel('t(s)')
axis ([0 5 -0.2 0.2])

subplot(212); plot(f,P1); % Fourier transform
title('Single-Sided Amplitude Spectrum of signal')
ylabel('Fast Fourier transform')
xlabel('f(Hz)')
axis ([0 400])

fig2 = figure; set(fig2,'name','Haar transform')
subplot(411); plot(t,signal); % Recorded signal
title('Recorded signal')
ylabel('Signal')
xlabel('t(s)')
axis ([0 5 -0.2 0.2])

subplot(412); plot(t2,trend); % Trend
title('Trend')
ylabel('Signal')
xlabel('t(s)')
axis ([0 2.5 -0.4 0.4])

subplot(413); plot(t2,fluc); % Fluctuation
title('Fluctuation')
ylabel('Signal')
xlabel('t(s)')
axis ([0 2.5 -0.4 0.4])

subplot(414); plot(t3,haar); % Haar transform
title('Haar transform')
ylabel('Signal')
xlabel('t(s)')
axis ([0 1.25 -0.8 0.8])