clear
%%
filename = '1.wav';

[y, Fs] = audioread(filename);

%%
figure
plot(y(:, 1))

%%
winLength = 2^10;
winStep = 2^4;

%window(1:winLength) = 1;
%window = window';
window = gausswin(winLength);
sampleLength = size(y, 1);
winNumber = fix( (sampleLength - winLength) / winStep ) + 1;
sample = y(1:(winLength + winStep * (winNumber - 1)), 1);

fourierTemp(1:winLength) = 0;
fourierResult(1:winNumber, 1:winLength) = 0;
for i = 1:winNumber
    fourierTemp = window .* sample((1 + winStep * (i - 1)):(winLength + winStep * (i - 1)));
    fourierResult(i, :) = fft(fourierTemp);
end

P2 = abs(fourierResult./winLength);
P1 = P2(:,1:winLength/2+1);
P1(:,2:end-1) = 2*P1(:,2:end-1);
P1 = fliplr(P1);

figure
imagesc(P1')

%f = Fs*(0:(winLength/2))/winLength;
ytick = get(gca, 'ytick');
set(gca, 'yticklabel', num2str(fix((size(P1, 2) - ytick') ./ size(P1, 2) .* Fs/2)))

%%
figure
plot(sum(P1,2))