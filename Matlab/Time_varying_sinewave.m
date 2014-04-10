  %% time varying signal
  
  % options
n = 10; % # frequencies 
fmean = 0.1; % Hz 
nsamples = 1e3; % # samples per constant freq period
% freq
tdur=1/fmean; 
ts = tdur/nsamples; 
f = (fmean/2)*randn(n,1)/3 + fmean;
fvec = []; 
for i=1:n, fvec = [fvec , f(i)*ones(1,nsamples)]; 
end
% algo
fac_old = 0; 
for i=1:length(fvec), fac = fac_old + fvec(i)*ts; 
    y(i) = sin(2*pi*fac); 
    fac_old = fac; 
end
% plot
subplot(211) 
    plot(0:tdur:tdur*(n-1),f,'k.',[0 tdur*n],fmean/2*[1 1],[0 tdur*n],fmean*[1.5 1.5]), ylim([0.25 1.75]*fmean)
subplot(212)
    plot(0:ts:ts*(length(y)-1),y)