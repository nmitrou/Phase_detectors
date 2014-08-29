%Trying to get a simple phase back from a simple sine wave
Time = (0:500000-1);
Period = length(Time)/100;
Freq = 1/Period;
SineWave = cos(Time*2*pi/Period);
figure(1); plot(Time, SineWave);
%%
Freqs = (Time(1:floor(length(Time)/2))./(length(Time)))./dt^2;
FTSineWave = fft(SgateData);
FTSineWave = FTSineWave(1:length(FTSineWave)/2);
Power = 2.*abs(FTSineWave);
figure(2);clf; plot(Freqs, Power);
[Max,Index] = max(Power);
[Maxtab,~] = peakdet(Power,prctile(Power,99.9));
Maxtab = Maxtab(:,1);
hold on; plot(Freqs(Maxtab),Power(Maxtab),'*r')
axis([0 2*Freqs(Index) 0 1.1*Max])
title('Power Spectrum')
%%
Phase = angle(FTSineWave);
figure(3);clf; ax2=plot(Freqs,Phase); hold on; plot(Freqs(Maxtab),Phase(Maxtab),'*r')
axis([0 2*Freqs(Index) 1.1*min(Phase) 1.1*max(Phase)])
Phase(Index)
WPhase = sum(Phase.*(Power/sum(Power)))
WPhase2 = sum(Phase(Maxtab).*(Power(Maxtab)))/sum(Power(Maxtab))
% %%
% %Internet example
% t = (0:99)/100;                        % Time vector
% x = sin(2*pi*15*t) + sin(2*pi*40*t);   % Signal
% y = fft(x);                            % Compute DFT of x
% p = unwrap(angle(y));                  % Phase
% f = (0:length(y)-1)/length(y)*100;     % Frequency vector
% figure(4); clf
% plot(f,p)
% xlabel 'Frequency (arb.)'
% ylabel 'Phase (rad)'