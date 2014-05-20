function [ InstaPhase ] = InstaPhaseWavelet( Signal1, dt )
%[ InstaPhase ] = InstaPhaseWavelet( Signal1 )
%%
Time = (0:dt:length(Signal1)-1);
[Wave,Period,~,~] = wavelet(Signal1,dt,0, 0.25, 100, 25);
figure(3); clf; imagesc(Time,Period,2.*abs(Wave));
end

