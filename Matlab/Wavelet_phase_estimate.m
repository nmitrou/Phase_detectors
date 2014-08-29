

F1 = 1;
F2 = 2;
a = 1;
Fs = 8;
dur = 30;
shift = 0;
Period1 = 1/F1;
Period2 = 1/F2;
dt = 1/Fs;                   % seconds per sample
t = (0:dt:dur-dt)';

x1 = makesine(F1,a,Fs,dur/2,shift);
x2 = makesine(F2,a,Fs,dur/2,shift);
xs = [x1; x2];

res=256; %frequency resolution
dt=1; %sampling rate
dj=0.0625; %wavelet interval
J1=127; %total # of scales
pad=1; %zero-pad signals
s0=2*dt; %set initial scale
mother='Morlet'; %wavelet shape
param=6; %initial wavelet order

%computes the wavelets
[WN1,~,scales] = wavelet(xs,dt,pad,dj,s0,J1,mother,param);
freq=1./(1.033*scales);
power = abs(WN1).^2;
%%
siz = size(power,2);

for k = 1:siz
    [~,idx(k)] = max(power(:,k));
    phase_max(k) = angle(WN1(idx(k),k));
end
phase_max_u = unwrap(phase_max);
phase_max_w = wrapToPi(phase_max_u);

plot(phase_max_w)

%%
imagesc(t,freq,power)
ylabel 'Frequency'