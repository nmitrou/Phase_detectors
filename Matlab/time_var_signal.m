function [y,f] = time_var_signal(nfreqs,fmean,fs,plot_key)
  
%%%%%%% inputs %%%%%%%%
% n - number of frequencies
% fmean - mean frequency
% fs - sample frequency
% plot_key - 1 for plot, 0 for no plot
% freq
tdur=1/fmean; 
ts = tdur/fs; 
f = (fmean/2)*(randn(nfreqs,1)) + fmean;
fvec = []; 
for i=1:nfreqs 
    fvec = [fvec , f(i)*ones(1,fs)]; 
end
% algo
fac_old = 0; 
for i=1:length(fvec)
    fac = fac_old + fvec(i)*ts; 
    y(i) = sin(2*pi*fac); 
    fac_old = fac; 
end
% plot
if plot_key == 1
subplot(211) 
    plot(0:tdur:tdur*(nfreqs-1),f,'k.',[0 tdur*nfreqs],fmean/2*[1 1],[0 tdur*nfreqs],fmean*[1.5 1.5]), ylim([0.25 1.75]*fmean)
subplot(212)
    plot(0:ts:ts*(length(y)-1),y)
end
end