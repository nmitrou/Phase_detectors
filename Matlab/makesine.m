function x = makesine(F,a,Fs,dur,shift)
% F1 = wave frequency (hz)
% a = amplitude
% Fs = sample frequency
% dur = duration in seconds
% shift = phase shift in radians
                  % samples per second
dt = 1/Fs;                   % seconds per sample
t = (0:dt:dur-dt)';     % seconds
x = a*cos(2*pi*F*(t+shift)); 
end