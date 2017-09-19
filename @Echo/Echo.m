classdef Echo < Effects
    % ECHO Applies an "echo" effect to recording
    %
    % Creates copies of the original data, each shifted by an increasing delay amount,
    %and multiplied by a scaling factor (this creates echoes that decay in volume). The
    % arrays are padded in order to be added together, creating the new data with the echo
    % effect. The delay amount and decay factor can be adjusted by the user.
    
    properties
    end
    
    methods (Static)
        function echo = Echo(data)
            echo = echo@Effects(data);
        end %constructor
        
        function newdata = apply(data)
            delay_amount = 27000;
            first = padarray(data,delay_amount,'post'); %first sound
            
            echo1 = .7*padarray(data,delay_amount/3,'pre'); %first echo, scaled down
            echo1 = padarray(echo1,delay_amount*(2/3),'post');
            
            echo2 = 0.5*padarray(data,delay_amount*(2/3),'pre'); %second echo, scaled down
            echo2 = padarray(echo2,delay_amount/3,'post');
            
            echo3 = 0.3*padarray(data,delay_amount,'pre'); %third echo, scaled down
            
            newdata = first + echo1 + echo2 + echo3;
        end
    end
end