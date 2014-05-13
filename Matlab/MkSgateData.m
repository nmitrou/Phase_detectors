function [ SgateData ] = MkSgateData(Length, dt,...
    PeakX1, PeakY1, STD1, Phase1, PeakX2, PeakY2, STD2, Phase2)
%[ SgateData ] = MkSgateData(Length, dt, Peak1, Phase1, Peak2, Phase2)
%
%MkSgateData creates a time series of (Length) seconds with 2 peaks in its frequency spectrum.
%
%Inputs
%   Length: the length in seconds, of the required data
%   dt: the data aquisition rate, in seconds
%   PeakX1: the frequency of the first oscillator
%   PeakY1: the power of the first oscillator in units*seconds
%   STD1: the width factor of the Gaussian creating Peak1
%   Phase1: Phase (in radians) of the first peak
%   PeakX2, PeakY2, STD2, Phase2: same as for 1
%
%Outputs
%   SgateData: The time series
%%
%Notes: 
%Maybe add some noise to the phase.
%This phase does NOT model time delay. it assumes a driving 'oscillator'
%that has a certain phase.
%%
[ FreqSpectrum, PhaseInfo ] = MkFreqSpectrum(Length, dt,...
    PeakX1, PeakY1, STD1, Phase1, PeakX2, PeakY2, STD2, Phase2);
DataFDomain = FreqSpectrum + 1i.*PhaseInfo;
SgateData = ifft(DataFDomain);
SgateData = real(SgateData);
SgateData = SgateData(1:round(length(SgateData)/2));
end
