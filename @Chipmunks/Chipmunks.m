classdef Chipmunks < Effects
    % CHIPMUNKS Applies "Chipmunk" effect to recording
    %
    % Uses the MATLAB function resample , but with a new sample rate of 1/2 
    % times the original sample rate. The smaller ratio of a/b corresponds to a 
    % faster effect and can be customized.
    
    properties
    end
    
    methods (Static)
        function chip = Chipmunks(data)
            chip = chip@Effects(data);
        end %constructor
        
        function newdata = apply(data)
            newdata = resample(data,1,2);
        end
    end
end