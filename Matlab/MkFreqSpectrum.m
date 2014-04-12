function [ FreqSpectrum, PhaseInfo ] = MkFreqSpectrum(Length, dt,...
    PeakX1, PeakY1, STD1, Phase1, PeakX2, PeakY2, STD2, Phase2)
%[ FreqSpectrum ] = MkFreqSpectrum(Length, dt, Peak1, STD1, Phase1, Peak2, STD2, Phase2)
%
%MkFreqSpectrum creates a frequency spectrum with 2 peaks using an addition
%of 2 gaussians of height PeakY, frequency PeakX, and standard deviation
%STD.
%
%Inputs
%   Length: the length in seconds, of the required data
%   dt: the data aquisition rate, in seconds
%   PeakX1: the frequency of the first oscillator
%   PeakY1: the power of the first oscillator in units*seconds
%   STD1: the standard deviation of the Gaussian creating Peak1
%   Phase1: Phase (in radians) of the first peak
%   PeakX2, PeakY2, STD2, Phase2: same as for 1
%   
%Outputs
%   FreqSpectrum: the real part of the Fourier transform.
%   PhaseInfo: the imaginary part of the Fourier transform. It returns
%   Phase1 when the first Gaussian is bigger than the second, and vice
%   versa.
%%
%Notes:
%
%%
Freqs = (1:2*Length/dt)./Length;
Gaussian1 = PeakY1.*gaussmf(Freqs,[STD1 PeakX1]);
Gaussian1 = Gaussian1.*([ones(length(Freqs(Freqs<PeakX1))),1,-ones(length(Freqs(Freqs>PeakX1)))]);
Gaussian2 = PeakY2.*gaussmf(Freqs,[STD2 PeakX2]);
Gaussian1 = Gaussian2.*([ones(length(Freqs(Freqs<PeakX2))),1,-ones(length(Freqs(Freqs>PeakX2)))]);
FreqSpectrum = Gaussian1+Gaussian2;
FreqSpectrum = [0, FreqSpectrum];
%%
TotalPhase = Phase2*ones(size(Gaussian1));
TotalPhase( abs(Gaussian1)>abs(Gaussian2) ) = Phase1;
TotalPhase( abs(Gaussian1)<abs(Gaussian2) ) = Phase2;
TotalPhase = [0, TotalPhase];
PhaseInfo = tan(TotalPhase).*FreqSpectrum;
end