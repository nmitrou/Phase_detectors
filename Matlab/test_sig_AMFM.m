function [x]=test_sig_AMFM(f1,f2,len,AM,FM,noi)
%TEST SIGNAL FOR TGF AM/FM on MYO
%AM = 1 to have amplitude modulation
%FM = 1 to have frequency modulation
%len = signal length
%noi = 1 to add WGN
%f1 = TGF Frequency
%f2 = MYO Frequency
%x = output signal
%tfr = time-frequency representation

t=1:len;

%generate low frequency component
phi1=-pi+2*pi*rand;
LF=sin(2*pi*f1.*t+phi1);

if AM ~= 1 && FM ~= 1
    phi2=-pi+2*pi*rand;
    HF=cos(2*pi*f2.*t+phi2);
elseif AM == 1 && FM ~=1
    %if AM but not FM
    phi2=-pi+2*pi*rand;
    HF=(1+0.75.*LF).*cos(2*pi*f2.*t+phi2);
elseif AM ~= 1 && FM ==1
    % if FM, no AM
    mHF=cos(2*pi*f1.*t);
    for n=1:length(t)
        mm(n)=sum(mHF(1:n));
    end
    HF=cos(2*pi*f2.*t+2*pi*f1.*mm);
elseif AM ==1 && FM == 1
    % if AM and FM
    mHF=cos(2*pi*f1.*t);
    for n=1:length(t)
        mm(n)=sum(mHF(1:n));
    end
    HF=(1+0.75.*LF).*cos(2*pi*f2.*t+2*pi*f1.*mm);
end

x=LF+HF;

%GENERATE IDEAL TFR OF TEST SIGNAL
% tfr=zeros(256,500);
% test=hilbert(HF');
% test=instfreq(test);
% for n=1:length(t)-2
%     k1=find(f<test(n));
%     k2=find(f>test(n));
%     kt=abs(test(n)-f(k1(end)));
%     ktt=abs(test(n)-f(k2(1)));
%     if kt<ktt
%         fcurr_ind(n)=k1(end);
%     else
%         fcurr_ind(n)=k2(1);
%     end
% end
% 
% for n=2:length(t)-1
%     tfr(fcurr_ind(n-1),n)=1+0.5.*LF(n);
% end
% 
% test=hilbert(LF');
% test=instfreq(test);
% for n=1:length(t)-2
%     k1=find(f<test(n));
%     k2=find(f>test(n));
%     kt=abs(test(n)-f(k1(end)));
%     ktt=abs(test(n)-f(k2(1)));
%     if kt<ktt
%         fcurr_ind(n)=k1(end);
%     else
%         fcurr_ind(n)=k2(1);
%     end
% end
% for n=2:length(t)-1
%     tfr(fcurr_ind(n-1),n)=1+0.25.*LF(n);
% end

%add WGN
if noi == 1
    x = x + randn(1,len);
end
