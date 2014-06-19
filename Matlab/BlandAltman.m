
function [Difference,MeanEst,MeanDiff,STDDiff] = BlandAltman(Sig1,Sig2,Graphic)

%%
EstPhases = [Sig1; Sig2];

MeanEst = mean(EstPhases,1);

Difference = Sig1 - Sig2;

MeanDiff = mean(Difference);
STDDiff = std(Difference);

if Graphic == 1
    plot(MeanEst,Difference,'ko')
    xlabel 'Phase'
    ylabel 'Difference'
    line([0 max(EstPhases)],[MeanDiff MeanDiff],'LineStyle','--','Color','k')
    line([0 max(EstPhases)],[1.96*STDDiff 1.96*STDDiff],'LineStyle','--','Color','r')
    line([0 max(EstPhases)],[-1.96*STDDiff -1.96*STDDiff],'LineStyle','--','Color','r')
end
%%
end
