classdef Reverse < Effects
    % REVERSE Applies a "reverse" effect to recording
    %
    % Reverses the recording by applying the MATLAB function flip , which simply flips the order of
    % the elements in data . This effect, given a melodic recording input, can make interesting ambient
    % sounds or used to mimic the quality of a string orchestra, especially combined with Reverb.
    
    properties
    end
    
    methods (Static)
        function reverse = Reverse(data)
            reverse = reverse@Effects(data);
        end %constructor
        
        function newdata = apply(data)
            newdata = flip(data);
        end
    end  
end
