function DetectionRatio = DetectionRatio(Signal,FS,FSigLow,FSigHigh,FNoiseLow,FNoiseHigh)
%%%%%% Detection ratio determines an index of signal:noise ratio in raw data

%%%%%%% Inputs %%%%%%%
% Signal - time domain data signal
% FSigLow - low end of frequency where the signal is likely to be
% FSigHigh - high end of frequency where the signal is likely to be
% FNoiseLow - low end of noise frequency range
% FNoiseHigh - high end of noise frequency range

%%%%%%% Outputs %%%%%%%
% Detection ratio

% find power spectrum using welch's method
[PSD,f] = pwelch(Signal,[],[],512,FS);

% find location in frequency range for signal and for noise
Sigfreq1 = find(f<FSigLow,1,'last');
Sigfreq2 = find(f>FSigHigh,1,'first');
Noifreq1 = find(f<FNoiseLow,1,'last');
Noifreq2 = find(f>FNoiseHigh,1,'first');
% get max power within signal range
Psig = max(PSD(Sigfreq1:Sigfreq2));
% get mean power within noise range
Pnoi = mean(PSD(Noifreq1:Noifreq2));
% calculate standard deviation of noise range power
SDnoi = std(PSD(Noifreq1:Noifreq2));
% calculate DR
DetectionRatio = 10*log10((Psig-Pnoi)/SDnoi);




end