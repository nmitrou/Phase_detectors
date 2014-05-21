function [freq,power,WN,scales,phase_max_u,phase_max_w,wi] =  wavelet_interp(x)

res=256; %frequency resolution
dt=1; %sampling rate
dj=0.0625; %wavelet interval
J1=127; %total # of scales
pad=1; %zero-pad signals
s0=2*dt; %set initial scale
mother='Morlet'; %wavelet shape
param=6; %initial wavelet order

%computes the wavelets
[WN,~,scales] = wavelet(x,dt,pad,dj,s0,J1,mother,param);
freq=1./(1.033*scales);
power = abs(WN).^2;

siz = size(power,2);

for k = 1:siz
    [~,idx(k)] = max(power(:,k));
    phase_max(k) = angle(WN(idx(k),k));
end
phase_max_u = unwrap(phase_max)';
phase_max_w = wrapToPi(phase_max_u)';

wi = (diff(phase_max_u).*2*2/pi)';
end