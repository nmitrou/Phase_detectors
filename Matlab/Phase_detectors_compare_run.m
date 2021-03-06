function [Time,TDSignal,TDPhaseUnwrap,TDPhase_Hilb,TDPhase_Wave,...
    Difference_Hilb1,MeanEst_Hilb1,MeanDiff_Hilb1,STDDiff_Hilb1,...
    Difference_Wave1,MeanEst_Wave1,MeanDiff_Wave1,STDDiff_Wave1,...
    Difference_Hilb,MeanEst_Hilb,MeanDiff_Hilb,STDDiff_Hilb,...
    Difference_Wave,MeanEst_Wave,MeanDiff_Wave,STDDiff_Wave] = ...
    Phase_detectors_compare_run(CentralFreq,STDFreq,Order,Length,DT,...
    Graphic,SNRMin,SNRMax,NoiseSteps, Filt)
%%
[TDSignal, TDPhase , TDPhaseUnwrap, Time, ~] = Time_varying_sinewave(CentralFreq, STDFreq, Order, Length, DT, Graphic);

% Add noise to test signal
NoiseVec = linspace(SNRMin,SNRMax,NoiseSteps);

GWNSignal = zeros([Length/DT+1,NoiseSteps]);
for k = 1:length(NoiseVec)
    GWNSignal(:,k) = awgn(TDSignal,NoiseVec(k),'measured');
end

% Estimate phase with hilbert transform
f1 = CentralFreq-(0.5*CentralFreq);
f2 = CentralFreq+(0.5*CentralFreq);


[TDPhase_Hilb, ~, ~] =  hilbert_interp(TDSignal,DT,Filt,f1,f2,Graphic);

GWNPhase_Hilb = zeros([Length/DT+1,NoiseSteps]);
GWNWrappedPhase_Hilb = zeros([Length/DT+1,NoiseSteps]);
for k = 1:NoiseSteps
    [GWNPhase_Hilb(:,k), ~, GWNWrappedPhase_Hilb(:,k)] = hilbert_interp(GWNSignal(:,k),DT,Filt, f1,f2,Graphic);
end
% Estimate phase with wavelet transform

[TDPhase_Wave, ~, ~] =  wavelet_interp(TDSignal, DT,Filt, f1, f2, Graphic);

GWNPhase_Wave = zeros([Length/DT+1,NoiseSteps]);
GWNWrappedPhase_Wave = zeros([Length/DT+1,NoiseSteps]);
for k = 1:NoiseSteps
    [GWNPhase_Wave(:,k), ~, GWNWrappedPhase_Wave(:,k)] = wavelet_interp(GWNSignal(:,k), DT, Filt, f1, f2, Graphic);
end

% Determine agreement between each estimate and the true phase (Bland-Altman)
GraphicBA = 0;
% for noise free signals

% cut off edges of each phase vector
    f1 = CentralFreq-(0.5*CentralFreq);
    
    CutS = ceil(3/f1/DT);

[Difference_Hilb1,MeanEst_Hilb1,MeanDiff_Hilb1,STDDiff_Hilb1] = BlandAltman(TDPhaseUnwrap(CutS:end-CutS),TDPhase_Hilb(CutS:end-CutS)',GraphicBA);
[Difference_Wave1,MeanEst_Wave1,MeanDiff_Wave1,STDDiff_Wave1] = BlandAltman(TDPhaseUnwrap(CutS:end-CutS),TDPhase_Wave(CutS:end-CutS),GraphicBA);
% for the noise 
for k = 1:NoiseSteps
    [Difference_Hilb(:,k),MeanEst_Hilb(:,k),MeanDiff_Hilb(k),STDDiff_Hilb(k)] = BlandAltman(TDPhase(CutS:end-CutS),GWNWrappedPhase_Hilb(CutS:end-CutS,k)',GraphicBA); 
    [Difference_Wave(:,k),MeanEst_Wave(:,k),MeanDiff_Wave(k),STDDiff_Wave(k)] = BlandAltman(TDPhase(CutS:end-CutS),GWNWrappedPhase_Wave(CutS:end-CutS,k)',GraphicBA); 
end

% plot(NoiseVec,MeanDiff_Hilb,'ko',NoiseVec,MeanDiff_Wave,'ro')
end



