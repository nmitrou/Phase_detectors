%%%% Phase detectors Figure 1

% generate simulated data
Phase_detectors_compare_trials
%%
SNRMin = -100;
SNRMax = 50;
NoiseSteps = 151;

NoiseVec = linspace(SNRMin,SNRMax,NoiseSteps);

GWNSignal = zeros([Length/DT+1,NoiseSteps]);
for k = 1:NoiseSteps
    GWNSignal(:,k) = awgn(TDSignal,NoiseVec(k),'measured');
end

SNRValue = -20; %The SNR to be plotted as the "noisy" signal (in dB)
SNRLoc = find(NoiseVec==SNRValue);

%% 
Filt = 1;
f1 = CentralFreq-0.5*CentralFreq;
f2 = CentralFreq+0.5*CentralFreq;

NoisyPhase_Wave =  wavelet_interp(GWNSignal(:,SNRLoc), DT, Filt, f1, f2, Graphic);
[NoisyPhase_Hilb,~] =  hilbert_interp(GWNSignal(:,SNRLoc),DT,Filt,f1,f2,Graphic);
%% plot signals, phases
w = 0.5;
h = 0.26;
s = 0.04;
l = 0.25;

b1 = 0.08;
b2 = b1 + h + s;
b3 = b2 + h + s;

FontN = 'Arial';
FontSz = 12;
LGrey = [0.5 0.5 0.5];
DGrey = [0.3 0.3 0.3];

YMax = 1.1*max(GWNSignal(:,SNRLoc));
YMin = 1.1*min(GWNSignal(:,SNRLoc));

figure(1)

subplot('Position',[l,b3,w,h])
    plot(Time,TDSignal,'k-')
        ylim([-1.2 1.2])
        set(gca,'XTickLabel','')

subplot('Position',[l,b2,w,h])
    plot(Time,GWNSignal(:,SNRLoc),'k-')
        ylim([YMin YMax])
        set(gca,'XTickLabel','')

subplot('Position',[l,b1,w,h])
    plot(Time,TDPhaseUnwrap,'k-'); hold on
    plot(Time,NoisyPhase_Hilb,'color',DGrey)
    plot(Time,NoisyPhase_Wave,'color',LGrey)
        legend('True','Hilbert','Wavelet','Location','NorthWest')





