function [TDPhase, TDPhaseCut, WrappedPhase] =  hilbert_interp(Signal_f,DT,Filt, f1,f2,Graphic)
%% Hilbert Interp %%
% function purpose is to use the hilbert transform of a signal and estimate
% the instantaneous phase and frequency of the signal
%%%%%%%%%% Inputs %%%%%%%%%%
% Signal - the time domain signal to be analyzed
% Dt - Time step for the signal i.e. 1/sample frequency
% f1 - lower bound of the frequency range for the oscillation of interest
% f2 - upper bound for the frequency range of the oscillation of interest
% Graphic - 1 for plots, 0 for no plots
%%%%%%%%%% Outputs %%%%%%%%%%
% TDPhase - unwrapped instantaneous phase with phase slips interpolated

Fs = 1/DT;  % Sampling Frequency
%FOR MYO
N   = 6;    % Order
% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.bandpass('N,F3dB1,F3dB2', N, f1, f2, Fs);
Hd = design(h, 'butter');
[b,a]=sos2tf(Hd.sosMatrix,Hd.ScaleValues);
if Filt
    Signal_f = filtfilt(b,a,Signal_f); %bandpass filter the input signal
end

xh = hilbert(Signal_f);
phh = angle(xh);
WrappedPhase = phh;
WrappedPhase = WrappedPhase;%Cut off edges to minimize edge effect
TDPhase = unwrap(phh);

CutS = ceil(3/f1*DT);

TDPhaseCut = TDPhase(CutS:end-CutS);

    w = diff(TDPhase).*(2*2/pi);
    wi = w;
%% find data points where inst. frequency is outside filter pass band, and interpolate across those points
 t = DT:DT:length(Signal_f)*DT;
 k1=find(wi<0);
 kk1=[k1;k1+1;k1-1];
 kk1(kk1<=0)=[];
 kk1(kk1>length(wi))=[];
 ti=t(2:end);
 ti = ti;
 tt=ti;
 tt(kk1)=[];
% wi(kk1)=[];
% length(tt)
% length(wi)
% length(ti)
% wi=interp1(tt,wi,ti,'linear','extrap'); 
%%
phh4=WrappedPhase(2:end);
phh4(kk1)=[];
phh4=interp1(tt,phh4,ti,'linear','extrap')';
phh4 = phh4;%Cut off edges to minimize edge effects

phhw = wrapToPi(phh4);

if Graphic == 1
    figure(102); clf;
    l = 0.15;
    w = 0.7;
    h = 0.35;
    s = 0.04;
    b1 = 0.1;
    b2 = b1 + h + s;
    
    
    tp = DT:DT:length(phhw)*DT;
    
    subplot('Position',[l,b2,w,h])
    plot(t,Signal_f,'k-')
    ylabel 'Amplitude'
    set(gca,'XTickLabel','')
    subplot('Position',[l,b1,w,h])
    plot(tp,phhw,'k.')
    ylabel 'Instantaneous phase (rad)'
    xlabel 'Time (s)'
end