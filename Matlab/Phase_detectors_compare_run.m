function [MeanDiff_Wave,MeanDiff_Hilb,STDDiff_Wave,STDDiff_Hilb] = Phase_detectors_compare_run(CentralFreq,STDFreq,Order,Length,DT,Graphic,SNRMin,SNRMax,NoiseSteps)
%% Make original test signal
CentralFreq = 0.5;
STDFreq = CentralFreq*0.2;
Order = 3;
Length = 1000;
DT = 0.1;
Graphic = 0;

[TDSignal, ~, TDPhaseUnwrap, Time, ~] = Time_varying_sinewave(CentralFreq, STDFreq, Order, Length, DT, Graphic);

% Add noise to test signal
SNRMin = -10;
SNRMax = 10;
NoiseSteps = 21;
NoiseVec = linspace(SNRMin,SNRMax,NoiseSteps);

for k = 1:NoiseSteps
    GWNSignal(:,k) = awgn(TDSignal,NoiseVec(k),'measured');
end

% Estimate phase with hilbert transform
f1 = CentralFreq-(0.5*CentralFreq);
f2 = CentralFreq+(0.5*CentralFreq);


TDPhase_Hilb =  hilbert_interp(TDSignal,DT,f1,f2,Graphic);

for k = 1:NoiseSteps
    GWNPhase_Hilb(:,k) = hilbert_interp(GWNSignal(:,k),DT,f1,f2,Graphic);
end
% Estimate phase with wavelet transform

TDPhase_Wave =  wavelet_interp(TDSignal, DT, Graphic);

for k = 1:NoiseSteps
    GWNPhase_Wave(:,k) = wavelet_interp(GWNSignal(:,k), DT, Graphic);
end

%% Determine agreement between each estimate and the true phase (Bland-Altman)
Graphic = 0;
% for noise free signals
[Difference_Hilb1,MeanEst_Hilb1,MeanDiff_Hilb1,STDDiff_Hilb1] = BlandAltman(TDPhaseUnwrap,TDPhase_Hilb',Graphic);
[Difference_Wave1,MeanEst_Wave1,MeanDiff_Wave1,STDDiff_Wave1] = BlandAltman(TDPhaseUnwrap,TDPhase_Wave,Graphic);
% for the noise 
for k = 1:NoiseSteps
    [Difference_Hilb(:,k),MeanEst_Hilb(:,k),MeanDiff_Hilb(k),STDDiff_Hilb(k)] = BlandAltman(TDPhaseUnwrap,GWNPhase_Hilb(:,k)',Graphic); 
    [Difference_Wave(:,k),MeanEst_Wave(:,k),MeanDiff_Wave(k),STDDiff_Wave(k)] = BlandAltman(TDPhaseUnwrap,GWNPhase_Wave(:,k)',Graphic); 
end
% plot(NoiseVec,MeanDiff_Hilb,'ko',NoiseVec,MeanDiff_Wave,'ro')
end



