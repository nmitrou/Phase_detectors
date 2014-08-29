%%%%%%%%%%%% Figure 2 %%%%%%%%%%%%

Phase_detectors_compare_trials
%%

for k = 1:floor(length(NoiseVec))
    PhaseDiff_HilbMean(k) = mean(MeanDiff_Hilb(:,k));
    PhaseDiff_WaveMean(k) = mean(MeanDiff_Wave(:,k));

    PhaseDiff_HilbSTD(k) = std(MeanDiff_Hilb(:,k));
    PhaseDiff_WaveSTD(k) = std(MeanDiff_Wave(:,k));
end

%%

figure(2); clf
errorbar(NoiseVec,PhaseDiff_HilbMean,PhaseDiff_HilbSTD,'k-'); hold on
errorbar(NoiseVec,PhaseDiff_WaveMean,PhaseDiff_WaveSTD,'r-')
    xlim([-81 61])
    ylim([-0.2 0.2])
    
%% Export table data
Row1 = {num2str(NoiseVec(51)),[num2str(PhaseDiff_HilbMean(51)) ' $\pm$ ' num2str(PhaseDiff_HilbSTD(51))],[num2str(PhaseDiff_WaveMean(51)) ' $\pm$ ' num2str(PhaseDiff_WaveSTD(51))]};

OutputLocation = '/Users/nickmitrou/Documents/SFU/PhD/Projects/Phase_detectors/Manuscript/TestTable.txt';

LatexTableFromData( OutputLocation, Row1 );
