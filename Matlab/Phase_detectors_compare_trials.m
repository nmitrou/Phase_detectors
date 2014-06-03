clear all;
clc
%%
tic

CentralFreq = 0.5;
STDFreq = CentralFreq*0.05;
Order = 4;
Length = 1000;
DT = 0.1;
Graphic = 0;

SNRMin = -10;
SNRMax = 10;
NoiseSteps = 21;
NoiseVec = linspace(SNRMin,SNRMax,NoiseSteps);


Trials = 20;

for k = 1:Trials
    [MeanDiff_Wave(k,:),MeanDiff_Hilb(k,:),STDDiff_Wave(k,:),STDDiff_Hilb(k,:)] = Phase_detectors_compare_run(CentralFreq,STDFreq,Order,Length,DT,Graphic,SNRMin,SNRMax,NoiseSteps);
end

toc
%% 
for k = 1:Trials
plot(NoiseVec,MeanDiff_Hilb(k,:),'k.',NoiseVec,MeanDiff_Wave(k,:),'ro'); hold on
xlabel 'SNR (dB)'
ylabel 'Estimate - True'
legend('Hilbert','Wavelet')
end