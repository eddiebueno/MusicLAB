classdef Effects < handle
    % EFFECTS Superclass for all Subclass effects to store data
    % 
    % A handle class with properties FXData and its only method is the constructor. FXData 
    % is a double that stores the data of the incoming audio signal, which is the raw data 
    % upon the first instance of applying an effect. This allows the child classes with specific
    % effects apply the necessary modifications to the incoming data and produce new data.
    
    properties
        FXData
    end
    
    methods
        function effect = Effects(data)
            effect.FXData = data;
        end %constructor
    end
    
end
