classdef Reverb < Effects
    % REVERB Applies a "reverb" effect to recording
    %
    % Creates padded copies of original data, each with increasing delay, and adds them together. 
    % To mimic reverb, or the sound of being in a ?big hall?, we want the hypothetical sound waves to
    % have a slight delay as they bounce of the walls and quickly decrease in volume as they do so. Thus, 
    % the delay is shorter and there are more copies of the data in comparison to Echo, and produces a fuller sound.
    
    properties
    end
    
    methods (Static)
        function reverb = Reverb(data)
            reverb = reverb@Effects(data);
        end %constructor
        
        function newdata = apply(data)
            delay_amount = 16000; %lenth(data)/8
            first = padarray(data,delay_amount,'post');            
            echo1 = 0.25*padarray(data,delay_amount/8,'pre');
                echo1 = padarray(echo1,delay_amount*(7/8),'post');                
            echo2 = 0.20*padarray(data,delay_amount*(2/8),'pre');
                echo2 = padarray(echo2,delay_amount*(6/8),'post');                
            echo3 = 0.15*padarray(data,delay_amount*(3/8),'pre');
                echo3 = padarray(echo3,delay_amount*(5/8),'post');                
            echo4 = 0.10*padarray(data,delay_amount*(4/8),'pre');
                echo4 = padarray(echo4,delay_amount*(4/8),'post');                
            echo5 = 0.05*padarray(data,delay_amount*(5/8),'pre');
                echo5 = padarray(echo5,delay_amount*(3/8),'post');                
            echo6 = 0.04*padarray(data,delay_amount*(6/8),'pre');
                echo6 = padarray(echo6,delay_amount*(2/8),'post');
            echo7 = 0.03*padarray(data,delay_amount*(7/8),'pre');
                echo7 = padarray(echo7,delay_amount*(1/8),'post');             
            echo8 = 0.02*padarray(data,delay_amount,'pre');
            newdata = first + echo1 + echo2 + echo3 + echo4 + echo5 + echo6 + echo7 + echo8;
            
        %When sound waves reflect off walls, two things happen:
            %They take longer to reach the listener.
            %They lose energy (get quieter) with every bounce.
        
        end
    end
end