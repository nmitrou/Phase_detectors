function [TDPhase, WrappedPhase] =  hilbert_interp(Signal,Dt,f1,f2,Graphic)
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

Fs = 1/Dt;  % Sampling Frequency
%FOR MYO
N   = 6;    % Order
% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.bandpass('N,F3dB1,F3dB2', N, f1, f2, Fs);
Hd = design(h, 'butter');
[b,a]=sos2tf(Hd.sosMatrix,Hd.ScaleValues);

Signal_f = filtfilt(b,a,Signal); %bandpass filter the input signal

xh = hilbert(Signal_f);
phh = angle(xh);
WrappedPhase = phh;
WrappedPhase = WrappedPhase(20:end-20);%Cut off edges to minimize edge effect
TDPhase = unwrap(phh(20:end-20));

    w = diff(TDPhase).*(2*2/pi);
    wi = w;
%% find data points where inst. frequency is outside filter pass band, and interpolate across those points
t = Dt:Dt:length(Signal_f)*Dt;
k1=find(wi<0);
kk1=[k1;k1+1;k1-1];
kk1(kk1<=0)=[];
kk1(kk1>length(wi))=[];
ti=t(2:end);
tt=ti;
tt(kk1)=[];
wi(kk1)=[];
wi=interp1(tt,wi,ti(20:end-20),'linear','extrap'); 
%%
phh4=phh(2:end);
phh4(kk1)=[];
phh4=interp1(tt,phh4,ti,'linear','extrap')';
phh4 = phh4(20:end-20);%Cut off edges to minimize edge effects

phhw = wrapToPi(phh4);

if Graphic == 1
    figure(102); clf;
    l = 0.15;
    w = 0.7;
    h = 0.35;
    s = 0.04;
    b1 = 0.1;
    b2 = b1 + h + s;
    
    
    tp = Dt:Dt:length(phhw)*Dt;
    
    subplot('Position',[l,b2,w,h])
    plot(t,Signal,'k-')
    ylabel 'Amplitude'
    set(gca,'XTickLabel','')
    subplot('Position',[l,b1,w,h])
    plot(tp,phhw,'k.')
    ylabel 'Instantaneous phase (rad)'
    xlabel 'Time (s)'
end