%%%%%%%%%%%%%% Phase detector simulation %%%%%%%%%%%%%%
% This script calls multiple other functions in order to make a series of sine waves
% with multiple frequencies and increasing levels of noise. The phase of each wave
% is then esimated with Wavelet and Hilbert transforms and their agreement wih the
% true phase of the original noise-free wave is shown with a Bland-Altman plot. Then
% the average agreement is shown at each noise level over multiple repetitions.

%%%%%%%%%%%% Inputs %%%%%%%%%%%% 
% CentralFreq - the central frequency of the sine wave
% STDFreq - standard deviation of the frequecy over time
% Order - the number of frequencies used in the wave
% Length - Duration of the wave in seconds
% DT - Time step of the wave, equal to 1/sample frequency
% Graphic - 1 for plots, 0 for no plots
% SNRMin - minimum signal to noise ratio in dB
% SNRMax - maximum signal to noise ratio
% NoiseSteps - number of individual signal to noise ratios to test
% Trials - Number of times to repeat the analysis

%%%%%%%%%%%% Outputs %%%%%%%%%%%% 

% TDSignal - Original sine wave with no noise
% TDPhaseUnwrap - True phase of TDSignal
% TDPhase_Hilb - Estimated phase with Hilbert method
% TDPhase_Wave - Estimated phase with Wavelet method
% Difference_Hilb1 - Difference between true phase and Hilbert estimated phase without noise
% MeanEst_Hilb1 - Mean of True phase and Hilbert estimated phase
% Difference_Wave1 - Difference between true phase and Wavelet estimated phase without noise
% MeanEst_Wave1 - Mean of True phase and Wavelet estimated phase

clear all
close all
clc
%%
tic

CentralFreq = 0.2;
STDFreq = CentralFreq*0.1;
Order = 12;
Length = 120;
DT = 0.1;
Graphic = 1;

SNRMin = -10;
SNRMax = 4;
NoiseSteps = 15;
NoiseVec = linspace(SNRMin,SNRMax,NoiseSteps);


Trials = 4;

for k = 1:Trials
    [Time,TDSignal,TDPhaseUnwrap,TDPhase_Hilb,TDPhase_Wave,Difference_Hilb1,MeanEst_Hilb1,MeanDiff_Hilb1,STDDiff_Hilb1,Difference_Wave1,MeanEst_Wave1,MeanDiff_Wave1,STDDiff_Wave1,Difference_Hilb,MeanEst_Hilb,MeanDiff_Hilb(k,:),STDDiff_Hilb(k,:),Difference_Wave,MeanEst_Wave,MeanDiff_Wave(k,:),STDDiff_Wave(k,:)] = Phase_detectors_compare_run(CentralFreq,STDFreq,Order,Length,DT,0,SNRMin,SNRMax,NoiseSteps);
% MeanDiff_Wave(k,:),MeanDiff_Hilb(k,:),STDDiff_Wave(k,:),STDDiff_Hilb(k,:)
end

toc
%
if Graphic == 1
%% Plot TDSignal

fontn = 'Times';
fontsz = 12;
Interpreter = 'Latex';
LineW = 2;
xmax = 100;
xmin = 0;
ymin = -1.2;
ymax = 1.2;
figure(1)
plot(Time,TDSignal,'k-','LineWidth',LineW)
xlim([xmin xmax])
ylim([ymin ymax])
% xlabel 'Time (s)'
% ylabel 'Amplitude'
% title 'Original signal'
text(((xmax-xmin)/2),-1.4,'Time (s)','HorizontalAlignment','center')
text(0,-6,'Ampltidude','HorizontalAlignment','center','Rotation',90)
%% Plot True, Hilbert and Wavelet Phase
figure(2)
plot(Time,TDPhaseUnwrap,'k-',Time,unwrap(TDPhase_Hilb),'bo',Time,TDPhase_Wave,'ro')
xlim([0 100])
xlabel 'Time (s)'
ylabel 'Phase (rad)'
legend('True','Hilbert','Wavelet')
    axes('Position',[0.6,0.2,0.3,0.3])
    box on
    xs = 100;
    xe = 120;
    plot(Time(xs:xe),TDPhaseUnwrap(xs:xe),'k-',Time(xs:xe),TDPhase_Hilb(xs:xe),'bo',Time(xs:xe),TDPhase_Wave(xs:xe),'ro')
    set(gca,'XTickLabel','','YTickLabel','')
    axis tight

%% Bland-Altman plot for noise-free signal
figure(3)
plot(MeanEst_Hilb1,Difference_Hilb1,'k-',MeanEst_Wave1,Difference_Wave1,'ro')
ylim([-1.5 1.5])
title 'Bland-Altman plot'
xlabel 'Mean Estimated phase'
ylabel 'Difference (Estimated phase - True phase)'
legend('Hilbert','Wavelet')
%
%     axes('Position',[0.6,0.2,0.3,0.3])
%     box on
%     xs = 100;
%     xe = 200;
%     Difference_Hilb1 = Difference_Hilb1';
%     Difference_Wave1 = Difference_Wave1';
%     plot(MeanEst_Hilb1(xs:xe),Difference_Hilb1(xs:xe),'k-',MeanEst_Wave1(xs:xe),Difference_Wave1(xs:xe),'ro')
%     set(gca,'XTickLabel','','YTickLabel','')
%     axis tight

%% Figure for Bland-Altman after trials at multiple SNR
figure(4)
for k = 1:Trials
plot(NoiseVec,MeanDiff_Hilb(k,:),'k.',NoiseVec,MeanDiff_Wave(k,:),'ro'); hold on
xlabel 'SNR (dB)'
ylabel 'Estimate - True'
legend('Hilbert','Wavelet')
end
end