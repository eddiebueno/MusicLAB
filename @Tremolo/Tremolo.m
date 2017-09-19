classdef Tremolo < Effects
    % TREMOLO Applies a "tremolo" effect to recording
    %
    % Creates a vector of sinusoidal data with customizable initial value, amplitude, and frequency.
    % This vector is concatenated with itself to create an array, called sin_vol, the same size as data. The array
    % sin_vol contains values between 0 and 1 and represents the intensity or volume. Thus, dot-multiplying
    % this array with the original data produces the tremolo effect of a wavering sound with oscillating volume
    % (think quickly twisting a volume knob back and forth). Thus, modifying the parameters of the sin wave
    % can modify the depth and speed of the volume change.
    
    properties
    end
    
    methods (Static)
        function tremolo = Tremolo(data)
            tremolo = tremolo@Effects(data);
        end %constructor
        
        function newdata = apply(data)        
            x = linspace(0, 8, length(data))';
            h = 0.5; %initial height
            a = 0.5; %amplitude a<=h
            f = 25; %frequency larger->faster
            y = h+a*sin(f*x); %sinusoidal vector, adjust h,a as desired
            sin_noise = [y y];
            newdata = data.*sin_noise; %scale data by sin vectors
        end
    end
end