function [TDPhase, WrappedPhase] =  wavelet_interp(TDSignal, DT, f1, f2, Graphic)
%%
Time = 0:length(TDSignal)-1;
Time=Time.*DT;
dj=0.04; %wavelet interval
J1=127; %total # of scales
pad=1; %zero-pad signals
s0=0.5; %set initial scale
mother='Morlet'; %wavelet shape
param=6; %initial wavelet order

Fs = 1/DT;  % Sampling Frequency
%FOR MYO
N   = 6;    % Order
% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.bandpass('N,F3dB1,F3dB2', N, f1, f2, Fs);
Hd = design(h, 'butter');
[b,a]=sos2tf(Hd.sosMatrix,Hd.ScaleValues);

if Filt
    TDSignal = filtfilt(b,a,TDSignal); %bandpass filter the input signal
end


%computes the wavelets
[WN,Period,~] = wavelet(TDSignal,DT,pad,dj,s0,J1,mother,param);
Power = abs(WN).^2;
%Freqs=1./(1.033.*Scale);
if Graphic
    figure(1);clf;
    mesh(Time, Period, Power) 
    view(90,45);
    colormap(hot)
end
%
Size = size(Power,2);
Phase_max = zeros(Size,1);
for k = 1:Size
    [~,TempPeriod] = max(Power(:,k));
    Phase_max(k) = mean(angle(WN(max(TempPeriod-2,1):min(TempPeriod+2,end),k)));
end
WrappedPhase = Phase_max';
Phase_max = Phase_max(20:end-20);%Cut off edges to minimize edge effects
TDPhase = unwrap(Phase_max)';
% size(Phase_max)
% TDPhase = wrapToPi(Phase_max_u)';
if Graphic
   figure(2); clf
   plot(TDPhase);
end
%wi = (diff(Phase_max_u).*2*2/pi)';
end