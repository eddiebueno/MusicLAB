classdef SlowMo < Effects
    % SLOWMO Applies a "slowm-motion" effect to recording
    %
    % Uses the MATLAB function resample , which resamples the values data at 3/2 (a/b) times
    % the original sample rate. The larger ratio of a/b corresponds to a slower effect and can
    % be customized by the user. This effect will make the audio sound like it is in slow-motion.
    
    properties
    end
    
    methods (Static)
        function slowmo = SlowMo(data)
            slowmo = slowmo@Effects(data);
        end %constructor
        
        function newdata = apply(data)
            newdata = resample(data,3,2);
        end
    end  
end
