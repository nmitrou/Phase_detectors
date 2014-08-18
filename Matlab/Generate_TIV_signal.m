%%%%%%%%%%%%%%%% Generate a set of time-invariant waves with increasing %%%%%%%%%%%%
%%%%%%%%%%%%%%%% uniform noise. Use Hilbert and wavelet methods to isolate %%%%%%%%%
%%%%%%%%%%%%%%%% the instantaneous frequency and phase of each wave %%%%%%%%%%%%%%%%

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

nRangeMin = 0;
nRangeMax = 1;
nSamples = 4;
gauss = 0;


x1 = makesine(F1,a,Fs,dur/2,shift);
x2 = makesine(F2,a,Fs,dur/2,shift);
xs = [x1; x2];

[x,noi] = addWhiteNoise(xs,nRangeMin,nRangeMax,nSamples,gauss);

siz = size(x,1);
freq1 = ones(siz/2,1).*F1;
freq2 = ones(siz/2,1).*F2;
freq = [freq1; freq2];

phase_step1 = (2*pi)/(Period1/dt);
phase_step2 = (2*pi)/(Period2/dt);

pht1 = 0:phase_step1:(length(t)/2)*phase_step1-phase_step1;
pht2 = (0:phase_step2:(length(t)/2)*phase_step2-phase_step2)+max(pht1);
pht = [pht1 pht2];

ang_freq = Fs*mean(diff(pht));

for k = 1:nSamples
[phh(:,k),phhu(:,k),phhw(:,k),w(:,k),wi(:,k)] =  hilbert_interp(x(:,k));
end

for k = 1:nSamples
[~,~,~,~,phase_max_u(k,:),phase_max_w(k,:),wi_w(k,:)] =  wavelet_interp(x(:,k));
end
%
wd = 0.4;
h = 0.4;
s = 0.04;
l1 = 0.08;
l2 = l1+wd+s;
b1 = 0.08;
b2 = b1+h+s;

subplot('Position',[l1,b2,wd,h])
plot(phhu)
ylabel 'Phase'
title Hilbert
ylim([-50 400])
set(gca,'XTickLabel','')
line([length(phhu)/2 length(phhu)/2],[-50 400],'LineStyle','--','color',[0.6 0.6 0.6])

subplot('Position',[l2,b2,wd,h])
plot(phase_max_u')
title Wavelet
set(gca,'XTickLabel','','YTickLabel','')
ylim([-50 400])
line([length(phhu)/2 length(phhu)/2],[-50 400],'LineStyle','--','color',[0.6 0.6 0.6])

subplot('Position',[l1,b1,wd,h])
plot(wi)
ylim([0 4])
ylabel 'Frequency'
line([length(phhu)/2 length(phhu)/2],[0 4],'LineStyle','--','color',[0.6 0.6 0.6])

subplot('Position',[l2,b1,wd,h])
plot(wi_w')
set(gca,'YTickLabel','')
ylim([0 4])
line([length(phhu)/2 length(phhu)/2],[-50 400],'LineStyle','--','color',[0.6 0.6 0.6])