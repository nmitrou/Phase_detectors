
function [Difference,MeanEst,MeanDiff,STDDiff] = BlandAltman(Sig1,Sig2,Graphic, FigNo)
%%
Size = size(Sig1);
if Size(1)>Size(2)
    EstPhases = [Sig1, Sig2];
else
    EstPhases = [Sig1; Sig2]';
end
MeanEst = mean(EstPhases,2);

Difference = Sig1 - Sig2;

MeanDiff = mean(Difference);
STDDiff = std(Difference);

if Graphic == 1
    figure(FigNo); clf;
    plot(MeanEst,Difference,'ko'); hold on;
    plot([min(MeanEst) max(MeanEst)],[MeanDiff MeanDiff],'r-');
    plot([min(MeanEst) max(MeanEst)],[MeanDiff+1.96*STDDiff MeanDiff+1.96*STDDiff],'r--');
    plot([min(MeanEst) max(MeanEst)],[MeanDiff-1.96*STDDiff MeanDiff-1.96*STDDiff],'r--');
    xlabel 'Mean'
    ylabel 'Difference'
end
end
