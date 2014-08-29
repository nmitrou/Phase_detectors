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
Graphic = 0;
NoisyPhase_Wave =  wavelet_interp(GWNSignal(:,SNRLoc), DT, Filt, f1, f2, Graphic);
[NoisyPhase_Hilb,~] =  hilbert_interp(GWNSignal(:,SNRLoc), DT, Filt, f1, f2, Graphic);
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
LGrey = [0.7 0.7 0.7];
DGrey = [0.3 0.3 0.3];

YMax = 1.1*max(GWNSignal(:,SNRLoc));
YMin = 1.1*min(GWNSignal(:,SNRLoc));

figure(1); clf

subplot('Position',[l,b3,w,h])
    plot(Time,TDSignal,'k-')
        ylim([-1.3 1.3])
        set(gca,'XTickLabel','')
        box off
        text(-15,0,'Amplitude','FontName',FontN,'FontSize',FontSz,'HorizontalAlignment','Center','Rotation',90)
        text(-20,1.3,'A','FontName',FontN,'FontSize',FontSz+4,'FontWeight','Bold','HorizontalAlignment','Center','Rotation',0)

        
subplot('Position',[l,b2,w,h])
    plot(Time,GWNSignal(:,SNRLoc),'k-')
        ylim([YMin YMax])
        set(gca,'XTickLabel','')
        box off
        text(-15,0,'Amplitude','FontName',FontN,'FontSize',FontSz,'HorizontalAlignment','Center','Rotation',90)
        text(-20,YMax,'B','FontName',FontN,'FontSize',FontSz+4,'FontWeight','Bold','HorizontalAlignment','Center','Rotation',0)

        
subplot('Position',[l,b1,w,h])
    plot(Time,TDPhaseUnwrap,'k--'); hold on
    plot(Time,NoisyPhase_Hilb,'color',DGrey)
    plot(Time,NoisyPhase_Wave,'color',LGrey)
        legend('True','Hilbert','Wavelet','Location','NorthWest')
        ylim([-5 180])
        box off
        text(-15,100,'Phase (rad)','FontName',FontN,'FontSize',FontSz,'HorizontalAlignment','Center','Rotation',90)
        text(60,-40,'Time (s)','FontName',FontN,'FontSize',FontSz,'HorizontalAlignment','Center','Rotation',0)
        text(-20,200,'C','FontName',FontN,'FontSize',FontSz+4,'FontWeight','Bold','HorizontalAlignment','Center','Rotation',0)
%%
print('-depsc2','/Users/nickmitrou/Documents/SFU/PhD/Projects/Phase_detectors/Results/Figure01.eps')



