%%%%%%%%% Phase difference in human cycling data %%%%%%%%%
% load data from one subject
    % 140 rpm cycling
    % achilles tendon force (N)
    % (Lateral) gastrocnemius muscle belly length (m)

load('/Users/nickmitrou/Documents/SFU/PhD/Projects/Phase_detectors/Data/CyclingData_TD.mat');
% sample frequency (Hz)
Fs = 20; 

% Fs presumed 40Hz, but I think it is 20Hz. Power peaks are at ~1Hz for
% both data sets, would expect 2.33Hz for 140RPM cycling?

Len = length(BellyLength);

Time = 1/Fs:1/Fs:Len/Fs;

plotyy(Time,BellyLength,Time,TendonForce)
% determine power spectra for both signals
[PSDLength,f] = pwelch(BellyLength,[],[],[],Fs);
[PSDForce,~] = pwelch(TendonForce,[],[],[],Fs);

%% estimate phase of each signal with Hilbert and Wavelet
FSigHigh = 4; % max for bandpass filter
FSigLow = 1; % min for bandpass filter
Dt = 1/Fs;
Graphic = 0; % 1 for plot, 0 for none
Filt = 1; % 1 for implementing bandpass, 0 for not
TDPhase_Hilb_L =  hilbert_interp(BellyLength,Dt,Filt,FSigLow,FSigHigh,Graphic);
TDPhase_Hilb_F =  hilbert_interp(TendonForce,Dt,Filt,FSigLow,FSigHigh,Graphic);

TDPhase_Wave_L = wavelet_interp(BellyLength, Dt, Filt, FSigLow, FSigHigh, Graphic);
TDPhase_Wave_F = wavelet_interp(TendonForce, Dt, Filt, FSigLow, FSigHigh, Graphic);
%%
subplot 121
plot(Time,TDPhase_Hilb_L,'k-',Time,TDPhase_Hilb_F,'r-')
xlabel 'Time (s)'
ylabel 'Phase (rad)'
legend('BellyLength','TendonForce')
title 'Hilbert'

subplot 122
plot(Time,TDPhase_Wave_L,'k-',Time,TDPhase_Wave_F,'r-')
xlabel 'Time (s)'
ylabel 'Phase (rad)'
legend('BellyLength','TendonForce')
title 'Wavelet'