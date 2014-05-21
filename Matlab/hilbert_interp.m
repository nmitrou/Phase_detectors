function [phh,phhu,phhw,w,wi] =  hilbert_interp(Signal,Dt,f1,f2,Graphic)
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
% phh - Instantaneous phase wrapped to 2pi
% phhu - Instantaneous phase unwrapped
% phhw - Instantaneous unwrapped phase rewrapped to Pi
% w = Instantaneous frequency
% wi = Instantaneous frequency with phase slipes interpolated

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
phhu = unwrap(phh);

    w = diff(phhu).*(2*2/pi);
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
wi=interp1(tt,wi,ti,'linear','extrap'); 
%%
phh4=phh(2:end);
phh4(kk1)=[];
phh4=interp1(tt,phh4,ti,'linear','extrap')';

phhw = wrapToPi(phh4);

if Graphic == 1
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