function [TDPhase, WrappedPhase] =  wavelet_interp(TDSignal, DT, Graphic)
%%
Time = 0:length(TDSignal)-1;
Time=Time.*DT;
dj=0.04; %wavelet interval
J1=127; %total # of scales
pad=1; %zero-pad signals
s0=0.5; %set initial scale
mother='Morlet'; %wavelet shape
param=6; %initial wavelet order

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
    Phase_max(k) = angle(WN(TempPeriod,k));
end
WrappedPhase = Phase_max';
TDPhase = unwrap(Phase_max)';
% size(Phase_max)
% TDPhase = wrapToPi(Phase_max_u)';
if Graphic
   figure(2); clf
   plot(TDPhase);
end
%wi = (diff(Phase_max_u).*2*2/pi)';
end