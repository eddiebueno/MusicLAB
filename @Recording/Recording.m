classdef Recording < handle
    % RECORDING Creates recording object
    %
    % A handle class with properties Rec, Data, and Effects. The constructor creates a
    % MATLAB audiorecorder object stored in the Rec property. The Data property is defined
    % either after a recording is taken or after an effect is applied by the user through 
    % the UI. For raw recordings, the Effect property will be empty, while for a recording
    % with effects applied, Effect will store an Effects object of a specific type (see Child classes of Effects).
    
    properties
        Rec
        Data
        Effects
    end
    
    methods
        % create audio recorder object
        % inputs: (sample rate in hertz, # of bits, # of channels)
        % sample rate= 44,100 hz bc common sampling rate used in digital audio
        function obj = Recording()
            obj.Rec = audiorecorder(44100, 16, 2); 
        end  
    end
    
end