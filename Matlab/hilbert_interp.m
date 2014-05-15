function [phh,phhu,phhw,w,wi] =  hilbert_interp(x)


xh = hilbert(x);
phh = angle(xh);
phhu = unwrap(phh);

    w = diff(phhu).*(2*2/pi);
    wi = w;
%%
t = 1:length(x);
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
end