function [Mean,U,Plot] = BlandAltman(V1,V2, Graphic)
%[Mean,U,Plot] = BlandAltman(V1,V2)
%You want to follow up a call to this function by something like
%   figure(11); clf; plot(Plot(1,:),Plot(2,:),'*');title('MCs')
%   hold on; plot([min(Plot(1,:)) max(Plot(1,:))],[Mean Mean],'k');
%   plot([min(Plot(1,:)) max(Plot(1,:))],[U U],'k');
%   plot([min(Plot(1,:)) max(Plot(1,:))],[-U -U],'k'); hold off;
%%
Size = size(V1);
if Size(1)>Size(2)
    V1=V1';
    V2=V2';
end
%%
Mean=(mean(V1-V2));
U=abs(1.96*(std(V1-V2)));
Plot=[(V1+V2)./2; (V1-V2)];
%%
if Graphic
    figure(11); clf; plot(Plot(1,:),Plot(2,:),'*');
    hold on; plot([min(Plot(1,:)) max(Plot(1,:))],[Mean Mean],'k');
    plot([min(Plot(1,:)) max(Plot(1,:))],[Mean+U Mean+U],'k');
    plot([min(Plot(1,:)) max(Plot(1,:))],[Mean-U Mean-U],'k'); hold off;
end
end

