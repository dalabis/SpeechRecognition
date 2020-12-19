clear, clc, close all

Fs = 8000; % частота квантовани€
f1 = 400; % частота заполнени€ одного из импульсов
f2 = 1200; % частота заполнени€ другого импульса
tau = 0.02; % длительность импульсов
t1 = 0.02; % врем€ прихода первого импульса
t2 = 0.06; % врем€ прихода второго импульса
dt = 1/Fs; % период квантовани€
t = 0:dt:0.1; % врем€
N = length(t); % количество отсчЄтов
% создаЄм сигналы, состо€щие из двух импульсов
% сигналы отличаютс€ тем, что импульсы с разной частотой
% приход€т в разном пор€дке
x1 = (t>=t1 & t<t1+tau).*sin(2*pi*f1*t)+ ...
 (t>=t2 & t<t2+tau).*sin(2*pi*f2*t);
x2 = (t>=t1 & t<t1+tau).*sin(2*pi*f2*t)+ ...
 (t>=t2 & t<t2+tau).*sin(2*pi*f1*t);

% сторим графики сигналов
figure
subplot(2,1,1), plot(t,x1,'k'), xlabel('t'), ylabel('x_1(t)')
subplot(2,1,2), plot(t,x2,'k'), xlabel('t'), ylabel('x_2(t)')

X1 = fft(x1); % дискретное преобразование ‘урье первого
X2 = fft(x2); % дискретное преобразование ‘урье второго
% частоты, соответствующие гармоникам
f = (ceil(N/2)-N:ceil(N/2)-1)*Fs/N;
% сторим графики амплитудных спектров сигналов
figure
subplot(2,1,1), stem(f, abs(fftshift(X1))/N, 'k.')
xlabel('f'), ylabel('|X_1|'), axis([0 1600 0 0.12])
subplot(2,1,2), stem(f, abs(fftshift(X2))/N, 'k.')
xlabel('f'), ylabel('|X_2|'), axis([0 1600 0 0.12]) 
% вычисл€ем оконное дискретное преобразование ‘урье
[Xw1,F,T] = spectrogram(x1,triang(128),64,128,Fs);
Xw2 = spectrogram(x2,triang(128),64,128,Fs);

c=(1:-0.05:0)'*[1 1 1]; % палитра цветов дл€ построени€

% строим контурные графики модул€ оконного преобразовани€

figure
subplot(2,1,1), contourf(T,F,abs(Xw1))
colormap(c), colorbar, grid on, axis([min(T) max(T) 0 1600])
xlabel('t'), ylabel('f'), title('|Xw_1(t,f)|')
subplot(2,1,2), contourf(T,F,abs(Xw2))
colormap(c), colorbar, grid on, axis([min(T) max(T) 0 1600])
xlabel('t'), ylabel('f'), title('|Xw_2(t,f)|')

% вычисл€ем оконное дискретное преобразование ‘урье
% уменьшили размер окна в 4 раза
[Xw1,F,T] = spectrogram(x1,triang(32),16,32,Fs);
Xw2 = spectrogram(x2,triang(32),16,32,Fs);

% строим контурные графики модул€ оконного преобразовани€

% вычисленного с окном другого размера
figure
subplot(2,1,1), contourf(T,F,abs(Xw1))
colormap(c), colorbar, grid on, axis([min(T) max(T) 0 1600])
xlabel('t'), ylabel('f'), title('|Xw_1(t,f)|')
subplot(2,1,2), contourf(T,F,abs(Xw2))
colormap(c), colorbar, grid on, axis([min(T) max(T) 0 1600])
xlabel('t'), ylabel('f'), title('|Xw_2(t,f)|') 