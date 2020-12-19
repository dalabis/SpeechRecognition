function [t,f,Fsig] = WinFFT(sig, wtype, woverlap, Fs)
%{
    WindowFFT ���������� ������� ��� � �����������:
    sig - �������� ������;
    wtype - ��� ����, �������� � ���� ������� (������������� �������� ���
    ����, ������ ������� ������);
    woverlap - ���������� ���� � �������� �������;
    Fs - ������� ������������� �������

    �������� ���������:
    t - ����� [c];
    f - ������� [��];
    Fsig - ������� �����-�������������� ������� sig.
%}

%{ 
    �������� ����� ������� �� ��������� ����� ����������. ���� ����� �������
    �� ������ ����� ����������, �� ��������� ������ ������ ������
%}
if mod(length(sig), woverlap) ~= 0                
    sig = [sig, zeros(1, woverlap * (fix(length(sig)/woverlap) + 1) - length(sig))];
end

N = length(wtype);                              % ���������� ��������
f = (0:ceil(N/2) - 1) * Fs /N;                  % �������, ��������������� ����������
dt = 1/Fs;                                      % ������ �����������
k = floor((length(sig) - woverlap)/(N - woverlap));  % ����� �������� �� ������� � ������ �������� ���
t = (N - woverlap).*dt.*(1:k);                  % �����

for ind = 1:k
    winsig(:,ind) = wtype.*(sig(woverlap * (ind - 1) + 1:woverlap * (ind - 1) + N))';
end

%% ��� - ������� �� ��������
Fsig = fft(winsig);
Fsig = Fsig(1:ceil(N/2),:);

