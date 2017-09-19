classdef Volume < handle
    %VOLUME Adjusts the volume of a recording
    %
    % Volume is a class that uses the java package javax.sound.sampled
    % in order to access the audio ports on the computer being used.
    % This java package provides interfaces and classes for capture,
    % processing, and playback of sampled audio data. This package is
    % used specifically to access the AudioSystem class which can
    % access various mixers installed on your system.
    
    properties
        Flags,Port,PortName,Mixer,Line,VolCtrl,Control
    end
    
    methods
        
        function obj = Volume()
            import javax.sound.sampled.*
            obj.Mixer = AudioSystem.getMixerInfo;
            obj.Flags = 0;
            obj.findPort();
            obj.OpenLine();
            obj.findVolumeControl();
        end
        
        function findPort(obj)
            % Loop over the system's mixers to find the speaker port
            import javax.sound.sampled.*
            for mixerIdx = 1 : length(obj.Mixer)
                mixer = AudioSystem.getMixer(obj.Mixer(mixerIdx));
                ports = getTargetLineInfo(mixer);
                for portIdx = 1 : length(ports)
                    obj.Port = ports(portIdx); %set the port
                    try
                        obj.PortName = obj.Port.getName;  % better
                    catch   %ok
                        obj.PortName = obj.Port.toString; % sub-optimal
                    end
                    if ~isempty(strfind(lower(char(obj.PortName)),'speaker')) || ~isempty(strfind(lower(char(obj.PortName)),'headphone'))
                        obj.Flags = 1;  break;
                    end
                end
            end
            if ~obj.Flags
                error('Speaker port not found');
            end
        end
        
        function OpenLine(obj)
            % Get and open the speaker port's Line object
            import javax.sound.sampled.*
            obj.Line = AudioSystem.getLine(obj.Port);
            obj.Line.open();
        end
        
        function findVolumeControl(obj)
            % Loop over the Line's controls to find the Volume control
            import javax.sound.sampled.*
            obj.VolCtrl = obj.Line.getControls;
            obj.Flags= 0;
            for ctrlIdx = 1 : length(obj.VolCtrl)
                obj.Control = obj.VolCtrl(ctrlIdx);
                ctrlName = char(obj.VolCtrl(ctrlIdx).getType);
                if ~isempty(strfind(lower(char(obj.PortName)),'speaker')) || ~isempty(strfind(lower(char(obj.PortName)),'headphone'))
                    obj.Flags = 1;  break;
                end
            end
            if ~obj.Flags
                error('Volume control not found');
            end
        end
        
        function volume = setVolume(obj,volume)
            % Get or set the volume value according to the user request
            import javax.sound.sampled.*
            oldValue = obj.Control.getValue;
            if nargin
                obj.Control.setValue(volume);
            end
            if nargout
                volume = oldValue;
            end
        end
        
        
        function volume = getVolume(obj)
            import javax.sound.sampled.*
            volume = obj.Control.getValue;
        end
    end %methods
    
end %class

