function [TDSignal, TDPhase, Time] = Time_varying_sinewave(CentralFreq, STDFreq, Order, Length, DT, Graphic)
%% time varying signal
%[Signal] = Time_varying_sinewave(CentralFreq, STDFreq, Order, Length)
  
  % options
Time = 0:DT:Length;
% freq
f = STDFreq*randn(Order,1) + CentralFreq;
TDSignal = [];
TDPhase = [];
for N = 1:Order
    Period = round(1/f(N)/DT);
    TempTime = 0:Period-1;
    TempSignal=cos(TempTime/Period*2*pi);
    TDSignal = [TDSignal,TempSignal];
    TempPhase = 0:2*pi/length(TempTime):2*pi-2*pi/length(TempTime);
    TDPhase = [TDPhase,TempPhase];
end
if length(Time)<length(TDSignal)
    fprintf('The specified length was too short \nto accomodate the order and sampling frequency.\n Length was changed to %d\n',length(TDSignal))
else
    while length(Time)>length(TDSignal)
       TDSignal = [TDSignal,TDSignal];
       TDPhase = [TDPhase,TDPhase];
    end
    TDSignal = TDSignal(1:length(Time));
    TDPhase = TDPhase(1:length(Time));
end

if Graphic
    figure(101); clf;
    ax1=subplot(211);
        plot(TDPhase)
    ax2=subplot(212);
        plot(TDSignal)
    linkaxes([ax1 ax2],'x')
end
end