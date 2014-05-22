%%% generate TV signal %%%

f1 = 0.1; %low frequency
f2 = 0.3; % high frequency
len = 500; % duration in seconds
AM = 1; % amplitude modulation 
FM = 0; % frequency modulation
noi = 0; % add GWN
t = 1:len;

[x]=test_sig_AMFM(f1,f2,len,AM,FM,noi);


 
% res=256; %frequency resolution
dt=1; %sampling rate
dj=0.0625; %wavelet interval
J1=127; %total # of scales
pad=1; %zero-pad signals
s0=2*dt; %set initial scale
mother='Morlet'; %wavelet shape
param=6; %initial wavelet order
% az = 63;
% el = 46;
az = 45;
el = 90;

%computes the wavelets
[WN1,~,scales] = wavelet(x,dt,pad,dj,s0,J1,mother,param);
freq=1./(1.033*scales);
power = abs(WN1).^2;

mesh(t,freq,power)
view(az,el)
colormap(hot)
xlabel('Time (s)')
ylabel('Frequency (Hz)')
zlabel('Power (Units^2/Hz)')

