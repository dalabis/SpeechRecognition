function [t,f,Fsig] = WinFFT(sig, wtype, woverlap, Fs)
%{
    WindowFFT производит оконное БПФ с параметрами:
    sig - исходный сигнал;
    wtype - тип окна, задается в виде массива (рекомендуется выбирать тип
    окна, равный степени двойки);
    woverlap - перекрытие окон в отсчетах сигнала;
    Fs - частота дискретизации сигнала

    Выходные параметры:
    t - время [c];
    f - частоты [Гц];
    Fsig - оконное Фурье-преобразование сигнала sig.
%}

%{ 
    Проверка длины сигнала на кратность числу перекрытий. Если длина сигнала
    не кратна числу перекрытий, то дополняем сигнал нулями справа
%}
if mod(length(sig), woverlap) ~= 0                
    sig = [sig, zeros(1, woverlap * (fix(length(sig)/woverlap) + 1) - length(sig))];
end

N = length(wtype);                              % количество отсчетов
f = (0:ceil(N/2) - 1) * Fs /N;                  % частоты, соответствующие гармоникам
dt = 1/Fs;                                      % период квантования
k = floor((length(sig) - woverlap)/(N - woverlap));  % число отсчетов по времени с учетом оконного БПФ
t = (N - woverlap).*dt.*(1:k);                  % время

for ind = 1:k
    winsig(:,ind) = wtype.*(sig(woverlap * (ind - 1) + 1:woverlap * (ind - 1) + N))';
end

%% БПФ - берется по столбцам
Fsig = fft(winsig);
Fsig = Fsig(1:ceil(N/2),:);

