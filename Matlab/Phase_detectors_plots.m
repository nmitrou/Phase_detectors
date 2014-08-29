%% Plot TDSignal
figure(1)
plot(Time,TDSignal,'k-')
xlim([0 100])
ylim([-1.2 1.2])
xlabel 'Time (s)'
ylabel 'Amplitude'
title 'Original signal'

%% Plot True, Hilbert and Wavelet Phase
figure(2)
plot(Time,TDPhaseUnwrap,'k-',Time,unwrap(TDPhase_Hilb),'bo',Time,TDPhase_Wave,'ro')
xlim([0 100])
axes('Position',[0.6,0.2,0.3,0.3])
box on
xs = 100;
xe = 120;
plot(Time(xs:xe),TDPhaseUnwrap(xs:xe),'k-',Time(xs:xe),TDPhase_Hilb(xs:xe),'bo',Time(xs:xe),TDPhase_Wave(xs:xe),'ro')
axis tight

%% Bland-Altman plot for noise-free signal
figure(3)
plot(MeanEst_Hilb1,Difference_Hilb1,'k-',MeanEst_Wave1,Difference_Wave1,'ro')
ylim([-0.5 0.5])
title 'Bland-Altman plot'
xlabel 'Mean Estimated phase'
ylabel 'Difference (Estimated phase - True phase)'
legend('Hilbert','Wavelet')

%% Figure for Bland-Altman after trials at multiple SNR
for k = 1:Trials
plot(NoiseVec,MeanDiff_Hilb(k,:),'k.',NoiseVec,MeanDiff_Wave(k,:),'ro'); hold on
xlabel 'SNR (dB)'
ylabel 'Estimate - True'
legend('Hilbert','Wavelet')
end