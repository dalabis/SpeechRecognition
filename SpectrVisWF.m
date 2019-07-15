function SpectrVisWF(Fsig,t,f)
%{ 
    Визуализация спектра в формате "waterfall"
%}

figure,
title('Spectrogram')
ylabel('time [s]')
xlabel('frequency [Hz]')
axis([0, Inf,min(t), Inf ])
hold on
for ind = 1:size(Fsig,2)
    plot(f, abs(Fsig(:,ind)) + t(ind),'k')
    hold on
end
hold off