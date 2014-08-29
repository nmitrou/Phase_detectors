clear all; clc;
%%
CentralFreq = 0.4;
STDFreq = CentralFreq*0.1;
Order = 50;
Length = 120;
DT = 0.1;
Graphic = 0;

SNRMin = -10;
SNRMax = -10;
NoiseSteps = SNRMax-SNRMin+1;
NoiseVec = linspace(SNRMin,SNRMax,NoiseSteps);


f1 = CentralFreq-(0.5*CentralFreq);
f2 = CentralFreq+(0.5*CentralFreq);
Filt=0;

Differences = [];
%%
for N = 1:50
    N
    [TDSignal, TDPhase , TDPhaseUnwrap, Time, ~] = Time_varying_sinewave(CentralFreq, STDFreq, Order, Length, DT, Graphic);
    NoisySignal = awgn(TDSignal,NoiseVec,'measured');
    [WTDPhase, WWrappedPhase] =  wavelet_interp(TDSignal, DT, Filt,f1, f2, Graphic);
    Difference =TDPhase-WWrappedPhase;
    Differences = [Differences,mean(Difference(abs(Difference)<pi))];
end
mean(Differences)
figure(69); clf; plot(Difference(abs(Difference)<pi))
