function [ SgateData, Time, Freqs ] = MkSgateData2( Length, dt,...
    Freq1, Power1, STD1, Phase1, Freq2, Power2, STD2, Phase2)
%[ SgateData ] = MkSgateData2( Length, dt, Freq1, Power1, STD1, Phase1, Freq2, Power2, STD2, Phase2)
%
%SgateData creates a time series from 2 oscillators of frequencies Freq1
%and Freq2, Phase1 and Phase2, with some frequency noise related to STD1 and STD2
%
%Length: length of the time series in seconds
%dt: sampling rate in seconds
%%
Time = (0:dt:Length);
Freqs = (Time(1:ceil(length(Time)/2))./(length(Time)))./dt^2;
Order = 1000;
%%
Oscillator1= zeros(size(Time));
Fuzz = STD1*randn(Order,1);
Fuzz2 = STD1*randn(Order,1)/5;
Fuzz=Fuzz-mean(Fuzz);
Fuzz2=fliplr(Fuzz2)-mean(fliplr(Fuzz2));
for N=1:Order
    N
    [~, Mindex] = min(abs(Freqs-(Freq1+Fuzz(N))));
    FuzzyFreq = Freqs(Mindex);
%    FuzzyFreq = (Freq1+Fuzz(N));
    FuzzyPhase = Phase1+Fuzz2(N);
    FuzzyPower = Power1*(max(abs(Fuzz))-abs(Fuzz(N)))/...
        sum(max(abs(Fuzz))-abs(Fuzz));
%   FuzzyPower=1;
    Oscillator1=Oscillator1+ awgn(FuzzyPower*...
        cos((Time)*(2*pi)*(FuzzyFreq)-FuzzyPhase),4,'measured');
end
%%
Oscillator2= zeros(size(Time));
Fuzz = STD2*randn(Order,1);
for N=1:Order
    FuzzyFreq = Freq2 + Fuzz(N);
    FuzzyPhase = Phase2 + Fuzz(N);
    FuzzyPower = Power2*(max(abs(Fuzz))-abs(Fuzz(N)))/...
        sum(max(abs(Fuzz))-abs(Fuzz));
    Oscillator2=Oscillator2+ FuzzyPower*...
        cos((Time)*(2*pi)*(FuzzyFreq)-FuzzyPhase);
end
%%
SgateData = Oscillator1;
% SgateData = Oscillator1+Oscillator2;
end

