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
signal = getaudiodata(audio);

%first_audio = 'recorded-audio-01.ogg';
%audiowrite(first_audio,signal,Fs);

% Signal
L = length(signal);   % Length of signal
t = (0:L-1)*T;        % Time vector

% Fast Fourier transform
nfft = 2048;       % Tamano del FFT
Y = fft(signal, nfft);
Y = Y(1:nfft/2);
my = abs(Y);
ft = (0:nfft/2-1)*Fs/nfft;

% Haar transform
t2 = (0:L/2-1)*T;
trend = (0:(L/2)-1);
j = 1;
for i=1:2:L
  trend(j) = sqrt(2)*(signal(i)+signal(i+1)); % First iteration: Trend
  j = j+1;
end

TREND = fft(trend, nfft);
TREND = TREND(1:nfft/2);
mtrend = abs(TREND);

t3 = (0:L/4-1)*T;
haar = (0:(L/4)-1)*T;
j = 1;
for i=1:2:L/2   
  haar(j) = sqrt(2)*(trend(i)+trend(i+1));    % Second iteration: Haar transform
  j = j+1;
end

HAAR = fft(haar, nfft);
HAAR = HAAR(1:nfft/2);
mhaar = abs(HAAR);

% Plots
fig2 = figure;
set(fig2,'name','Haar transform');
subplot(5,2,[1,2]);
plot(t,signal); % Recorded signal
title('Recorded signal');
ylabel('Signal Amplitude');
xlabel('t(s)');

subplot(5,2,3);
plot(t2,trend); % Trend
title('1st Trend Haar transform');
ylabel('Amplitude');
xlabel('t(s)');

subplot(5,2,4);
plot(t3,haar); % Haar transform
title('2nd Trend Haar transform');
ylabel('Signal');
xlabel('t(s)');

subplot(5,2,[5,6]);
hold on;
plot(ft,my,'b');
title('FFT');
xlabel('Frequency (Hz)');
ylabel('Power');
xlim([0,1500]);
hold off;

subplot(5,2,[7,8]);
hold on;
plot(ft,mtrend,'r');
title('FFT');
xlabel('Frequency (Hz)');
ylabel('Power');
xlim([0,1500]);
hold off;

subplot(5,2,[9,10]);
hold on;
plot(ft,mhaar,'g');
title('FFT');
xlabel('Frequency (Hz)');
ylabel('Power');
xlim([0,1500]);
hold off;

play(audio);
sighaar1 = 'haar1.ogg';
audiowrite(sighaar1, trend, Fs/2);