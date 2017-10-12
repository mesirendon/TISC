clear all;
close all;
clc;

Fs = 1000;         % Frecuencia de muestreo
f = 60;            % Onda seno de 5Hz
N = 5;
tmin = 0;
tmax = 1/f*N;
t = tmin:1/Fs:tmax;    % Vector de tiempo a 1 segundo
x = sin(2*pi*t*f); % Funcion
nfft = 2048;       % Tamano del FFT
X = fft(x, nfft);
X = X(1:nfft/2);
mx = abs(X);
ft = (0:nfft/2-1)*Fs/nfft;

% Haar transform
t2 = linspace(tmin,tmax/2,length(x)/2);
trend = linspace(tmin,tmax/2,length(x)/2);
j = 1;
for i=1:2:length(x)
  trend(j) = sqrt(2)*(x(i)+x(i+1)); % First iteration: Trend
  j = j+1;
end

TREND = fft(trend, nfft);
TREND = TREND(1:nfft/2);
mtrend = abs(TREND);

fluc = linspace(tmin,tmax/2,length(x)/2);
j = 1;
for i=1:2:length(x)
  fluc(j) = sqrt(2)*(x(i)-x(i+1));  % First iteration: Fluctuation
  j = j+1;
end

t3 = linspace(tmin,tmax/4,length(x)/4);
haar = linspace(tmin,tmax/4,length(x)/4);
j = 1;
for i=1:2:length(x)/2
  haar(j) = sqrt(2)*(trend(i)+trend(i+1));    % Second iteration: Haar transform
  j = j+1;
end

HAAR = fft(haar, nfft);
HAAR = HAAR(1:nfft/2);
mhaar = abs(HAAR);

figure(1);
subplot(211);
hold on;
plot(t,x);
title(['f = ', num2str(f), 'Hz']);
xlabel('Time (s)');
ylabel('Amplitude');
hold off;

subplot(212);
plot(ft, mx);
title(['Power spectrum of f = ', num2str(f), 'Hz']);
xlabel('Frequency (Hz)');
ylabel('Power');
text (60, 40, "f = 60Hz");

figure(2);
subplot(4,2,[1,2]);
hold on;
plot(t,x);
title(['f = ', num2str(f), 'Hz']);
xlabel('Time (s)');
ylabel('Amplitude');
hold off;

subplot(4,2,3);
plot(t2, trend);
title('1st Haar transform: trend component');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(4,2,5);
plot(t3, haar);
title('2nd Haar transform: trend component');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(4,2,[4,6]);
plot(t2, fluc);
title('1st Haar transform: fluctuation component');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(4,2,[7,8]);
hold on;
plot(ft, mx);
plot(ft, mtrend, 'r');
plot(ft, mhaar, 'g');
title('Frequency response of Fs, Haar 1, Haar 2');
xlabel('Frequency (Hz)');
ylabel('Power');
text (60, 50, "f = 60Hz");
text (120, 70, "f = 120Hz");
text (240, 70, "f = 240Hz");
hold off;