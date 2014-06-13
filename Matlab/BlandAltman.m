
function [Difference,MeanEst,MeanDiff,STDDiff] = BlandAltman(Sig1,Sig2,Graphic)
%%

EstPhases = [Sig1; Sig2]';

MeanEst = mean(EstPhases,2);

Difference = Sig1 - Sig2;

MeanDiff = mean(Difference);
STDDiff = std(Difference);

if Graphic == 1
    plot(MeanEst,Difference,'ko')
    xlabel 'Phase'
    ylabel 'Difference'
end
end
