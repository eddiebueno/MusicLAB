% Most updated: May 1st, 2017

classdef Project < handle
    % PROJECT MusicLAB App
    %
    % The main class that contains the methods for the app, such as to create GUI,
    % record sound, play sound, apply effects to recordings, and play new recordings.
    %
    % Execute the following to start the Project class:
    %   >> P = Project;
    %   >> P.runUI;
    
    properties
        Audio1; % Vocals1 raw
        Audio2; % Vocals1 effects
        Vocal2;
        Vocal2Eff;
        GuitarPiano;
        GuitarPianoEff;
        Drums;
        DrumsEff;
    end
    
    methods
        function app = Project()
            app.Audio1 = Recording();
            app.Audio2 = Recording();
            app.Vocal2= Recording();
            app.Vocal2Eff= Recording();
            app.GuitarPiano= Recording();
            app.GuitarPianoEff= Recording();
            app.Drums= Recording();
            app.DrumsEff= Recording();
        end
        
        function runUI(Project)
            close all;
            Project.Audio1.Data=[];
            Project.Audio2.Data=[];
            Project.Vocal2.Data=[];
            Project.Vocal2Eff.Data=[];
            Project.GuitarPiano.Data=[];
            Project.GuitarPianoEff.Data=[];
            Project.Drums.Data=[];
            Project.DrumsEff.Data=[];
            nameEdit=[];
            importEdit=[];
            % 44100 is a common sampling rate for digital audio
            fs=44100;
            recentdata = [];
            %%%%%%%%%%%%%%%%%%%%%%%%%
            % Create figure and 3 panels: effectsPanel, plotPanel, buttonPanel
            %%%%%%%%%%%%%%%%%%%%%%%%%
            f = figure('Menubar','none',...
                'NumberTitle', 'off','Units','normalized','Position',[0.03 .04 .94 .88]);
            set(f,'units','normalized','position',[0.1406 0.1625 0.625 0.665]);
            set(f,'Name','MusicLAB Project');
            effectsPanel = uipanel('Parent',f,'Position',[.7,0,.3,.9],'HighlightColor', [0 0 0]);
            plotPanel = uipanel('Parent',f,'Position',[0,0,.7,.9],'HighlightColor', [0 0 0]);
            buttonPanel=uipanel('Parent',f,'Position',[0,.9,1,.1],'HighlightColor', [0 0 0]);
            set(plotPanel, 'BackgroundColor', 0.2*[1 1 1])
            set(effectsPanel, 'BackgroundColor', 0.2*[1 1 1])
            
            %%%%%%%%%%%%%%%%%%%%%%%%%
            % woodPanel controls
            %%%%%%%%%%%%%%%%%%%%%%%%%
            woodPanel1=uipanel('Parent',f,'Position',[0,0,.015,.9],'HighlightColor', [0 0 0],'BackgroundColor',[0 0 0]);
            woodPanel2=uipanel('Parent',f,'Position',[.985,0,.015,.9],'HighlightColor', [0 0 0],'BackgroundColor',[0 0 0]);
            
            %%%%%%%%%%%%%%%%%%%%%%%%%
            % plotPanel controls
            %%%%%%%%%%%%%%%%%%%%%%%%%
            % Track 1 Panel
            track1Panel=uipanel('Parent',f,'Position',[.015,.45,.7-.015,.45],'HighlightColor', [0 0 0],'BackgroundColor',[0 0 0]);
            set(track1Panel, 'BackgroundColor', 0.2*[1 1 1]);
            track1PanelText=uicontrol('Parent',track1Panel,'style','text','units','normalized','position',[0.15 0 0.8 0.1],...
                'string','Track 1 (raw)','FontSize',16,'FontName','Courier','BackgroundColor',get(track1Panel,'BackgroundColor'),...
                'ForegroundColor',[1 1 1],'FontWeight','bold');
            % Text labels for Vocals 1, Vocals 2, Guitar/Piano, Drums
            v1Text=uicontrol('Parent',track1Panel,'style','text','units','normalized','position',[0.02 0.74 0.12 0.1],...
                'string','Vocals 1','FontSize',12,'FontName','Courier','BackgroundColor',get(track1Panel,'BackgroundColor'),...
                'ForegroundColor',[1 1 1]);
            v2Text=uicontrol('Parent',track1Panel,'style','text','units','normalized','position',[0.02 0.54 0.12 0.1],...
                'string','Vocals 2','FontSize',12,'FontName','Courier','BackgroundColor',get(track1Panel,'BackgroundColor'),...
                'ForegroundColor',[1 1 1]);
            gpText=uicontrol('Parent',track1Panel,'style','text','units','normalized','position',[0.02 0.36 0.12 0.1],...
                'string','Guitar/','FontSize',12,'FontName','Courier','BackgroundColor',get(track1Panel,'BackgroundColor'),...
                'ForegroundColor',[1 1 1]);
            gp2Text=uicontrol('Parent',track1Panel,'style','text','units','normalized','position',[0.02 0.32 0.12 0.08],...
                'string','Piano','FontSize',12,'FontName','Courier','BackgroundColor',get(track1Panel,'BackgroundColor'),...
                'ForegroundColor',[1 1 1]);
            dText=uicontrol('Parent',track1Panel,'style','text','units','normalized','position',[0.02 0.14 0.12 0.1],...
                'string','Drums','FontSize',12,'FontName','Courier','BackgroundColor',get(track1Panel,'BackgroundColor'),...
                'ForegroundColor',[1 1 1]);
            
            % plot on Track1Panel
            plotAxes = axes('Parent',track1Panel);
            plot1=subplot(4,1,1);
            ax=gca;
            yticklabels({});
            set(ax,'XAxisLocation','top','Color',[1 1 1],'XColor',[1 1 1],'YColor',[1 1 1],'FontName','Courier');
            set(plot1,'Color',[0.6 0.6 0.6],'XGrid','on','GridColor',[1 1 1]);
            set(plot1,'Position',[0.1500    0.7073    0.7750    0.20])
            
            plot2=subplot(4,1,2);
            ax=gca;
            yticklabels({});
            set(ax,'XAxisLocation','top','Color',[1 1 1],'XColor',[1 1 1],'YColor',[1 1 1],'FontName','Courier');
            set(plot2,'Color',[0.6 0.6 0.6],'XGrid','on','GridColor',[1 1 1]);
            xticklabels({});
            set(plot2,'Position',[0.1500    0.5073    0.7750    0.20])
            
            plot3=subplot(4,1,3);
            ax=gca;
            yticklabels({});
            set(ax,'XAxisLocation','top','Color',[1 1 1],'XColor',[1 1 1],'YColor',[1 1 1],'FontName','Courier');
            set(plot3,'Color',[0.6 0.6 0.6],'XGrid','on','GridColor',[1 1 1]);
            xticklabels({});
            set(plot3,'Position',[0.1500    0.3073    0.7750    0.20])
            
            plot4=subplot(4,1,4);
            ax=gca;
            yticklabels({});
            set(ax,'XAxisLocation','top','Color',[1 1 1],'XColor',[1 1 1],'YColor',[1 1 1],'FontName','Courier');
            set(plot4,'Color',[0.6 0.6 0.6],'XGrid','on','GridColor',[1 1 1]);
            xticklabels({});
            set(plot4,'Position',[0.1500    0.1073    0.7750    0.20])
            
            % Track 2 Panel
            track2Panel=uipanel('Parent',f,'Position',[.015,0,.7-.015,.45],'HighlightColor', [0 0 0],'BackgroundColor',[0 0 0]);
            set(track2Panel, 'BackgroundColor', 0.2*[1 1 1]);
            track2PanelText=uicontrol('Parent',track2Panel,'style','text','units','normalized','position',[0.15 0 0.8 0.1],...
                'string','Track 2 (effects applied)','FontSize',16,'FontName','Courier','BackgroundColor',get(track2Panel,'BackgroundColor'),...
                'ForegroundColor',[1 1 1],'FontWeight','bold');
            % Text labels for Vocals 1, Vocals 2, Guitar/Piano, Drums (Effects)
            v1EffText=uicontrol('Parent',track2Panel,'style','text','units','normalized','position',[0.02 0.74 0.12 0.1],...
                'string','Vocals 1','FontSize',12,'FontName','Courier','BackgroundColor',get(track2Panel,'BackgroundColor'),...
                'ForegroundColor',[1 1 1]);
            v2EffText=uicontrol('Parent',track2Panel,'style','text','units','normalized','position',[0.02 0.54 0.12 0.1],...
                'string','Vocals 2','FontSize',12,'FontName','Courier','BackgroundColor',get(track2Panel,'BackgroundColor'),...
                'ForegroundColor',[1 1 1]);
            gpEffText=uicontrol('Parent',track2Panel,'style','text','units','normalized','position',[0.02 0.36 0.12 0.1],...
                'string','Guitar/','FontSize',12,'FontName','Courier','BackgroundColor',get(track2Panel,'BackgroundColor'),...
                'ForegroundColor',[1 1 1]);
            gp2EffText=uicontrol('Parent',track2Panel,'style','text','units','normalized','position',[0.02 0.32 0.12 0.08],...
                'string','Piano','FontSize',12,'FontName','Courier','BackgroundColor',get(track2Panel,'BackgroundColor'),...
                'ForegroundColor',[1 1 1]);
            dEffText=uicontrol('Parent',track2Panel,'style','text','units','normalized','position',[0.02 0.14 0.12 0.1],...
                'string','Drums','FontSize',12,'FontName','Courier','BackgroundColor',get(track2Panel,'BackgroundColor'),...
                'ForegroundColor',[1 1 1]);
            % plot on Track2Panel
            plotAxes = axes('Parent',track2Panel);
            plot1=subplot(4,1,1);
            ax=gca;
            yticklabels({});
            set(ax,'XAxisLocation','top','Color',[1 1 1],'XColor',[1 1 1],'YColor',[1 1 1],'FontName','Courier');
            set(plot1,'Color',[0.6 0.6 0.6],'XGrid','on','GridColor',[1 1 1]);
            set(plot1,'Position',[0.1500    0.7073    0.7750    0.20])
            
            plot2=subplot(4,1,2);
            ax=gca;
            yticklabels({});
            set(ax,'XAxisLocation','top','Color',[1 1 1],'XColor',[1 1 1],'YColor',[1 1 1],'FontName','Courier');
            set(plot2,'Color',[0.6 0.6 0.6],'XGrid','on','GridColor',[1 1 1]);
            xticklabels({});
            set(plot2,'Position',[0.1500    0.5073    0.7750    0.20])
            
            plot3=subplot(4,1,3);
            ax=gca;
            yticklabels({});
            set(ax,'XAxisLocation','top','Color',[1 1 1],'XColor',[1 1 1],'YColor',[1 1 1],'FontName','Courier');
            set(plot3,'Color',[0.6 0.6 0.6],'XGrid','on','GridColor',[1 1 1]);
            xticklabels({});
            set(plot3,'Position',[0.1500    0.3073    0.7750    0.20])
            
            plot4=subplot(4,1,4);
            ax=gca;
            yticklabels({});
            set(ax,'XAxisLocation','top','Color',[1 1 1],'XColor',[1 1 1],'YColor',[1 1 1],'FontName','Courier');
            set(plot4,'Color',[0.6 0.6 0.6],'XGrid','on','GridColor',[1 1 1]);
            xticklabels({});
            set(plot4,'Position',[0.1500    0.1073    0.7750    0.20])
            
            % check box buttons
            % Track 1 check box buttons
            vocals1check=uicontrol(track1Panel,'style','checkbox','units','normalized','position',[0.9400 0.7573 0.024 0.0476],'backgroundcolor',get(track1Panel,'backgroundcolor'));
            vocals2check=uicontrol(track1Panel,'style','checkbox','units','normalized','position',[0.9400 0.5573 0.024 0.0476],'backgroundcolor',get(track1Panel,'backgroundcolor'));
            guitarcheck=uicontrol(track1Panel,'style','checkbox','units','normalized','position',[0.9400 0.3573 0.024 0.0476],'backgroundcolor',get(track1Panel,'backgroundcolor'));
            drumscheck=uicontrol(track1Panel,'style','checkbox','units','normalized','position',[0.9400 0.1573 0.024 0.0476],'backgroundcolor',get(track1Panel,'backgroundcolor'));
            
            % Track 2 check box buttons
            vocals1effcheck=uicontrol(track2Panel,'style','checkbox','units','normalized','position',[0.9400 0.7573 0.024 0.0476],'backgroundcolor',get(track1Panel,'backgroundcolor'));
            vocals2effcheck=uicontrol(track2Panel,'style','checkbox','units','normalized','position',[0.9400 0.5573 0.024 0.0476],'backgroundcolor',get(track1Panel,'backgroundcolor'));
            guitareffcheck=uicontrol(track2Panel,'style','checkbox','units','normalized','position',[0.9400 0.3573 0.024 0.0476],'backgroundcolor',get(track1Panel,'backgroundcolor'));
            drumseffcheck=uicontrol(track2Panel,'style','checkbox','units','normalized','position',[0.9400 0.1573 0.024 0.0476],'backgroundcolor',get(track1Panel,'backgroundcolor'));
            
            %%%%%%%%%%%%%%%%%%%%%%%%%
            % buttonPanel controls
            %%%%%%%%%%%%%%%%%%%%%%%%%
            % different controls for PC and Mac
            if ispc
                % PC Record and Master Volume Settings
                % Stop button
                [x,map]=imread('stop3.jpg');
                I2=imresize(x,[30,30]);
                stopButton = uicontrol(buttonPanel,'style','pushbutton',...
                    'Units','normalized','Position',[.47,.15,.07,.72],...
                    'CallBack',@stopButtonCallback,'cdata',I2,'BackgroundColor',[1 1 1]);
                stopStr = '<html>Stop';
                set(stopButton,'tooltipString',stopStr);
                % Play button
                [x,map]=imread('playbut.jpeg');
                I2=imresize(x,[30,30]);
                playButton = uicontrol(buttonPanel,'style','pushbutton',...
                    'Units','normalized','Position',[.54,.15,.07,.72],...
                    'CallBack',@playButtonCallback,'cdata',I2,'BackgroundColor',[1 1 1]);
                playStr = '<html>Play';
                set(playButton,'tooltipString',playStr);
                % Record button
                [x,map]=imread('record2.jpg');
                I2=imresize(x,[30,30]);
                recordButton = uicontrol(buttonPanel,'style','togglebutton',...
                    'Units','normalized','Position',[0.4,.15,.07,.72],...
                    'foregroundcolor',[1 0 0],...
                    'CallBack',@recordButtonCallback,'cdata',I2,'BackgroundColor',[1 1 1]);
                recordStr = '<html>Record';
                set(recordButton,'tooltipString',recordStr);
                % record button
                recordText=uicontrol(buttonPanel,'style','text','string','Recording...',...
                    'Units','normalized','Position',[0.17 0.25 .17 .42],'FontWeight','Bold','BackgroundColor',[0 0 0],...
                    'ForegroundColor',[0.3 0.3 0.3],'FontSize',16,'FontName','Courier');
                
                % Master Volume button
                vol = Volume();
                volumeSlider=uicontrol(buttonPanel,'style','slider','Units','normalized','Position',[0.66,0.35,.1,.3],'Value',1,'Min',0,'Max',1,'Callback',@(source,event)vol.setVolume(get(source,'Value')));
                volumeStr = '<html>Master Volume';
                set(volumeSlider,'tooltipString',volumeStr);
                addlistener(volumeSlider,'Value','PostSet',@(soure,event)vol.setVolume(get(volumeSlider,'Value')));
                
            else
                % Mac/ other platforms Record and Master Volume Settings
                % Stop button
                [x,map]=imread('stop3.jpg');
                I2=imresize(x,[30,30]);
                stopButton = uicontrol(buttonPanel,'style','pushbutton',...
                    'Units','normalized','Position',[.47,.25,.07,.5],...
                    'CallBack',@stopButtonCallback,'cdata',I2,'BackgroundColor',[1 1 1]);
                stopStr = '<html>Stop';
                set(stopButton,'tooltipString',stopStr);
                % Play button
                [x,map]=imread('playbut.jpeg');
                I2=imresize(x,[30,30]);
                playButton = uicontrol(buttonPanel,'style','pushbutton',...
                    'Units','normalized','Position',[.54,.25,.07,.5],...
                    'CallBack',@playButtonCallback,'cdata',I2,'BackgroundColor',[1 1 1]);
                playStr = '<html>Play';
                set(playButton,'tooltipString',playStr);
                % Record button
                [x,map]=imread('record2.jpg');
                I2=imresize(x,[30,30]);
                recordButton = uicontrol(buttonPanel,'style','togglebutton',...
                    'Units','normalized','Position',[0.4,.15,.07,.82],...
                    'foregroundcolor',[1 0 0],...
                    'CallBack',@recordButtonCallback,'cdata',I2,'BackgroundColor',[1 1 1]);
                recordStr = '<html>Record';
                set(recordButton,'tooltipString',recordStr);
                % record button
                recordText=uicontrol(buttonPanel,'style','text','string','Recording...',...
                    'Units','normalized','Position',[0.17 0.25 .17 .42],'FontWeight','Bold','BackgroundColor',[0 0 0],...
                    'ForegroundColor',[0.3 0.3 0.3],'FontSize',16,'FontName','Courier');
                
                % Master Volume button
                vol = Volume();
                volumeSlider=uicontrol(buttonPanel,'style','slider','Units','normalized','Position',[0.63,0.54,.1,.05],'Min',0,'Max',1,'Callback',@(source,event)vol.setVolume(get(source,'Value')));
                volumeStr = '<html>Master Volume';
                set(volumeSlider,'tooltipString',volumeStr);
                addlistener(volumeSlider,'Value','PostSet',@(soure,event)vol.setVolume(get(volumeSlider,'Value')));
                
            end
            
            % Change background of buttonPanel to a picture
            ah = axes('Parent',buttonPanel,'unit', 'normalized', 'position', [0 0 1 1]);
            %bg = imread('graypic.jpg'); imagesc(bg);
            bg = imread('wood.jpg'); imagesc(bg);
            set(ah,'handlevisibility','off','visible','off')
            
            % delete button to delete selected plots
            clearRawbutton=uicontrol(buttonPanel,'style','pushbutton','Units','normalized','Position',[0.04,0.28,.08,.3],'string',...
                'delete','FontName','Courier','FontSize',13,'Callback',@clearRawCallback);
            deleteStr = '<html>Delete track';
                set(clearRawbutton,'tooltipString',deleteStr);
            
            %%%%%%%%%%%%%%%%%%%%%%%%%
            % effectsPanel controls
            %%%%%%%%%%%%%%%%%%%%%%%%%
            % Create fxPanel
            fxPanel = uipanel('Parent',effectsPanel,...
                'Units', 'normalized',...
                'Position',[0.1,0.3,0.8,0.48],'HighlightColor', [0 0 0]);
            fxText=uicontrol('Parent',effectsPanel,...
                'Units','normalized','Position', [.09,.78,.8,.035],...
                'Style','text',...
                'FontSize', 16,'FontName','Courier',...
                'String','Choose an Effect','ForegroundColor',[1 1 1],'BackgroundColor',(get(effectsPanel,'BackgroundColor')),'FontWeight','bold');
            
            % Submit Effects button
            submitButton = uicontrol('Parent',effectsPanel,...
                'Style','pushbutton','FontName','Courier',...
                'String','Submit Effect','Units','normalized','Position',[.2,.23,.6,.05],'FontSize',12,...
                'Callback',@submitButtonCallback);
            submitStr = '<html>Submit Effect';
            set(submitButton,'tooltipString',submitStr);
            
            % Clear Effects button
            clearButton=uicontrol('Parent',effectsPanel,...
                'Style','pushbutton','FontName','Courier',...
                'String','Clear Effects','Units','normalized','Position',[.2,.17,.6,.05],'FontSize',12,...
                'Callback',@clearButtonCallback);
            clearStr = '<html>Clear Effects';
            set(clearButton,'tooltipString',clearStr);
            
            % Change background of fxPanel to a picture
            ah = axes('Parent',fxPanel,'unit', 'normalized', 'position', [0 0 1 1]);
            bg = imread('meta2.jpg'); imagesc(bg);
            set(ah,'handlevisibility','off','visible','off')
            
            % effects Toggle buttons
            reverseToggle=uicontrol('Parent',fxPanel,'Style','togglebutton','string','Reverse',...
                'Units','normalized','Position', [0.001,.83-0.02,.998,.1],'FontName','Courier','FontSize',18,...
                'Callback',@reverseToggleCallBack);
            reverseStr = '<html>Reverse';
            set(reverseToggle,'tooltipString',reverseStr);
            reversePanel=uipanel('Parent',effectsPanel,'Units', 'normalized',...
                'Position',[.04,.69,.05,.03],'HighlightColor', get(effectsPanel,'BackgroundColor'),'ShadowColor',get(effectsPanel,'BackgroundColor'));
            % add a pic to say its on/off -> callback for each button
            ah = axes('Parent',reversePanel,'unit', 'normalized', 'position', [0 0 1 1]);
            bg = imread('off.jpg'); imagesc(bg);
            set(ah,'handlevisibility','off','visible','off')
            
            tremoloToggle=uicontrol('Parent',fxPanel,'Style','togglebutton','string','Tremolo',...
                'Units','normalized','Position', [0.001,.7-0.02,.998,.1],'FontName','Courier','FontSize',18,...
                'Callback',@tremoloToggleCallBack);
            tremoloStr = '<html>Tremolo';
            set(tremoloToggle,'tooltipString',tremoloStr);
            tremoloPanel=uipanel('Parent',effectsPanel,'Units', 'normalized',...
                'Position',[.04,.63,.05,.03],'HighlightColor', get(effectsPanel,'BackgroundColor'),'ShadowColor',get(effectsPanel,'BackgroundColor'));
            % add a pic to say its on/off -> callback for each button
            ah = axes('Parent',tremoloPanel,'unit', 'normalized', 'position', [0 0 1 1]);
            bg = imread('off.jpg'); imagesc(bg);
            set(ah,'handlevisibility','off','visible','off')
            
            echoToggle=uicontrol('Parent',fxPanel,'Style','togglebutton','string','Echo',...
                'Units','normalized','Position', [0.001,.57-0.02,.998,.1],'FontName','Courier','FontSize',18,...
                'Callback',@echoToggleCallBack);
            echoStr = '<html>Echo';
            set(echoToggle,'tooltipString',echoStr);
            echoPanel=uipanel('Parent',effectsPanel,'Units', 'normalized',...
                'Position',[.04,.57,.05,.03],'HighlightColor', get(effectsPanel,'BackgroundColor'),'ShadowColor',get(effectsPanel,'BackgroundColor'));
            % add a pic to say its on/off -> callback for each button
            ah = axes('Parent',echoPanel,'unit', 'normalized', 'position', [0 0 1 1]);
            bg = imread('off.jpg'); imagesc(bg);
            set(ah,'handlevisibility','off','visible','off')
            
            reverbToggle=uicontrol('Parent',fxPanel,'Style','togglebutton','string','Reverb',...
                'Units','normalized','Position', [0.001,.44-0.02,.998,.1],'FontName','Courier','FontSize',18,...
                'Callback',@reverbToggleCallBack);
            reverbStr = '<html>Reverb';
            set(reverbToggle,'tooltipString',reverbStr);
            reverbPanel=uipanel('Parent',effectsPanel,'Units', 'normalized',...
                'Position',[.04,.51,.05,.03],'HighlightColor', get(effectsPanel,'BackgroundColor'),'ShadowColor',get(effectsPanel,'BackgroundColor'));
            % add a pic to say its on/off -> callback for each button
            ah = axes('Parent',reverbPanel,'unit', 'normalized', 'position', [0 0 1 1]);
            bg = imread('off.jpg'); imagesc(bg);
            set(ah,'handlevisibility','off','visible','off')
            
            slowMoToggle=uicontrol('Parent',fxPanel,'Style','togglebutton','string','Slow-Mo',...
                'Units','normalized','Position', [0.001,.31-0.02,.998,.1],'FontName','Courier','FontSize',18,...
                'Callback',@slowmoToggleCallBack);
            slowMoStr = '<html>Slow-Mo';
            set(slowMoToggle,'tooltipString',slowMoStr);
            slowmoPanel=uipanel('Parent',effectsPanel,'Units', 'normalized',...
                'Position',[.04,.45,.05,.03],'HighlightColor', get(effectsPanel,'BackgroundColor'),'ShadowColor',get(effectsPanel,'BackgroundColor'));
            % add a pic to say its on/off -> callback for each button
            ah = axes('Parent',slowmoPanel,'unit', 'normalized', 'position', [0 0 1 1]);
            bg = imread('off.jpg'); imagesc(bg);
            set(ah,'handlevisibility','off','visible','off')
            
            chipmunksToggle=uicontrol('Parent',fxPanel,'Style','togglebutton','string','Chipmunks',...
                'Units','normalized','Position', [0.001,.18-0.02,.998,.1],'FontName','Courier','FontSize',18,...
                'Callback',@chipmunksToggleCallBack);
            chipmunksStr = '<html>Clear Effects';
            set(chipmunksToggle,'tooltipString',chipmunksStr);
            chipPanel=uipanel('Parent',effectsPanel,'Units', 'normalized',...
                'Position',[.04,.39,.05,.03],'HighlightColor', get(effectsPanel,'BackgroundColor'),'ShadowColor',get(effectsPanel,'BackgroundColor'));
            % add a pic to say its on/off -> callback for each button
            ah = axes('Parent',chipPanel,'unit', 'normalized', 'position', [0 0 1 1]);
            bg = imread('off.jpg'); imagesc(bg);
            set(ah,'handlevisibility','off','visible','off')
            
            %%%%%%%%%%%%%%%%%%%%%%%%%
            % Menu bar
            %%%%%%%%%%%%%%%%%%%%%%%%%
            workspaceMenu = uimenu('Label','File');
            uimenu(workspaceMenu,'Label','New Recording','Callback',@newRecordingCallback);
            uimenu(workspaceMenu,'Label','Import .wav File','Callback',@ImportCallback);
            fr=uimenu(workspaceMenu,'Label','Save as...');
            uimenu(workspaceMenu,'Label','Quit','Callback',@QuitCallback,...
                'Separator','on','Accelerator','Q');
            uimenu(fr,'Label','.wav','Callback',@wavCallback);
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %CALLBACKS%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            % Clear Raw Recording Callback
            function clearRawCallback(hObject,eventdata)
                % check if the boxes are selected
                CheckboxStateTRACK1(1)=get(vocals1check,'value');
                CheckboxStateTRACK1(2)=get(vocals2check,'value');
                CheckboxStateTRACK1(3)=get(guitarcheck,'value');
                CheckboxStateTRACK1(4)=get(drumscheck,'value');
                
                checkedPlots=find(CheckboxStateTRACK1==1);
                display('deleting tracks...');
                
                for i=1:length(checkedPlots)
                    if checkedPlots(i)==1
                        % delete data for that section
                        % re-plot for vocals 1
                        % set the data
                        importData=[];
                        Project.Audio1.Data=importData;
                        recentdata{1}=importData;
                        % plot
                        HELPERPLOT(Project,checkedPlots(i),track1Panel,fs,importData);
                        
                    elseif checkedPlots(i)==2
                        % plot for vocals 2
                        importData=[];
                        Project.Vocal2.Data=importData;
                        recentdata{2}=importData;
                        % plot
                        HELPERPLOT(Project,checkedPlots(i),track1Panel,fs,importData);
                        
                    elseif checkedPlots(i)==3
                        % plot for guitar/piano
                        importData=[];
                        Project.GuitarPiano.Data=importData;
                        recentdata{3}=importData;
                        % plot
                        HELPERPLOT(Project,checkedPlots(i),track1Panel,fs,importData);
                        
                    elseif checkedPlots(i)==4
                        % plot for drums
                        importData=[];
                        Project.Drums.Data=importData;
                        recentdata{4}=importData;
                        % plot
                        HELPERPLOT(Project,checkedPlots(i),track1Panel,fs,importData);
                    end
                end
            end
            
            % Import file Callback
            function ImportCallback(hObject,eventdata)
                % create a new window to type the file name
                importfigure=figure('Menubar','none',...
                    'NumberTitle', 'off','Units','normalized','Position',[0.3 .5 .3 .2]);
                set(importfigure,'name','Import .wav file','windowstyle','modal');
                importEdit=uicontrol(importfigure,'style','edit','Units','normalized','Position',[0.2 .5 .6 .18]);
                importText=uicontrol(importfigure,'style','text','string','Import:','Units','normalized',...
                    'Position',[0.05 .48 .15 .18],'FontSize',14,'Callback',@importTextwavcallback);
                IMPORTbutton=uicontrol(importfigure,'style','pushbutton','Units','normalized','Position',[0.3 .2 .2 .16],...
                    'Callback',@IMPORTwavcallback,'string','Upload','FontSize',12);
                set(IMPORTbutton, 'Value', 1);
                cancelimport=uicontrol(importfigure,'style','pushbutton','Units','normalized','Position',[0.5 .2 .2 .16],...
                    'Callback',@cancelIMPORTwavcallback,'string','Cancel','FontSize',12);
            end
            
            function IMPORTwavcallback(hObject,eventdata)
                % if the file name is not recognized -> throw an error
                importName = get(importEdit,'String');
                if exist([importName '.wav'], 'file')
                    
                    % if it is recognized -> read the uploaded data
                    importName = get(importEdit,'String');
                    
                    % read the uploaded data
                    [importData,Fs]=audioread([importName '.wav']);
                    % importData=sampled data, Fs=sample frequency
                    
                    % find the checked checkboxes -> check box property
                    CheckboxStateTRACK1(1)=get(vocals1check,'value');
                    CheckboxStateTRACK1(2)=get(vocals2check,'value');
                    CheckboxStateTRACK1(3)=get(guitarcheck,'value');
                    CheckboxStateTRACK1(4)=get(drumscheck,'value');
                    
                    if gt(sum(CheckboxStateTRACK1),1)
                        % throw error if more than one box is checked
                        errordlg('Select only one box to Upload .wav file')
                        
                    elseif eq(sum(CheckboxStateTRACK1),0)
                        % no boxes are checked -> throw and error
                        errordlg('Select a checkbox in Raw Recording to Upload .wav file');
                        
                    else
                        % can upload a .wav file
                        checkedPlots=find(CheckboxStateTRACK1==1);
                        display('Uploading .wav file...');
                        for i=1:length(checkedPlots)
                            if checkedPlots(i)==1
                                % plot for vocals 1
                                % set the data
                                Project.Audio1.Data=importData;
                                recentdata{1}=importData;
                                namefig=gcf;
                                close(namefig);
                                % plot
                                HELPERPLOT(Project,checkedPlots(i),track1Panel,fs,importData);
                                
                            elseif checkedPlots(i)==2
                                % plot for vocals 2
                                Project.Vocal2.Data=importData;
                                recentdata{2}=importData;
                                namefig=gcf;
                                close(namefig);
                                % plot
                                HELPERPLOT(Project,checkedPlots(i),track1Panel,fs,importData);
                                
                            elseif checkedPlots(i)==3
                                % plot for guitar/piano
                                Project.GuitarPiano.Data=importData;
                                recentdata{3}=importData;
                                namefig=gcf;
                                close(namefig);
                                % plot
                                HELPERPLOT(Project,checkedPlots(i),track1Panel,fs,importData);
                                
                            elseif checkedPlots(i)==4
                                % plot for drums
                                Project.Drums.Data=importData;
                                recentdata{4}=importData;
                                namefig=gcf;
                                close(namefig);
                                % plot
                                HELPERPLOT(Project,checkedPlots(i),track1Panel,fs,importData);
                            end
                        end
                        
                    end
                else % file doesn't exist
                    errordlg('File name does not exist');
                    
                end
            end % end IMPORTwavcallback
            
            function cancelIMPORTwavcallback(hObject,eventdata)
                namefig=gcf;
                delete(namefig);
            end
            
            % chipmunks toggle button
            function chipmunksToggleCallBack(hObject,eventdata)
                button_state = get(hObject,'Value');
                if button_state == get(hObject,'Max')
                    % button is pushed down meaning to show green pic
                    ah = axes('Parent',chipPanel,'unit', 'normalized', 'position', [0 0 1 1]);
                    bg = imread('on.jpg'); imagesc(bg);
                    set(ah,'handlevisibility','off','visible','off')
                    
                elseif button_state == get(hObject,'Min')
                    % button is pushed up meaning to show gray pic
                    ah = axes('Parent',chipPanel,'unit', 'normalized', 'position', [0 0 1 1]);
                    bg = imread('off.jpg'); imagesc(bg);
                    set(ah,'handlevisibility','off','visible','off')
                end
            end % end chipmunksToggleCallBack
            
            % slow-mo toggle button
            function slowmoToggleCallBack(hObject,eventdata)
                button_state = get(hObject,'Value');
                if button_state == get(hObject,'Max')
                    % button is pushed down meaning to show green pic
                    ah = axes('Parent',slowmoPanel,'unit', 'normalized', 'position', [0 0 1 1]);
                    bg = imread('on.jpg'); imagesc(bg);
                    set(ah,'handlevisibility','off','visible','off')
                    
                elseif button_state == get(hObject,'Min')
                    % button is pushed up meaning to show gray pic
                    ah = axes('Parent',slowmoPanel,'unit', 'normalized', 'position', [0 0 1 1]);
                    bg = imread('off.jpg'); imagesc(bg);
                    set(ah,'handlevisibility','off','visible','off')
                end
            end % end slowmoToggleCallBack
            
            % reverb toggle button
            function reverbToggleCallBack(hObject,eventdata)
                button_state = get(hObject,'Value');
                if button_state == get(hObject,'Max')
                    % button is pushed down meaning to show green pic
                    ah = axes('Parent',reverbPanel,'unit', 'normalized', 'position', [0 0 1 1]);
                    bg = imread('on.jpg'); imagesc(bg);
                    set(ah,'handlevisibility','off','visible','off')
                    
                elseif button_state == get(hObject,'Min')
                    % button is pushed up meaning to show gray pic
                    ah = axes('Parent',reverbPanel,'unit', 'normalized', 'position', [0 0 1 1]);
                    bg = imread('off.jpg'); imagesc(bg);
                    set(ah,'handlevisibility','off','visible','off')
                end
            end % end reverbToggleCallBack
            
            % echo toggle button
            function echoToggleCallBack(hObject,eventdata)
                button_state = get(hObject,'Value');
                if button_state == get(hObject,'Max')
                    % button is pushed down meaning to show green pic
                    ah = axes('Parent',echoPanel,'unit', 'normalized', 'position', [0 0 1 1]);
                    bg = imread('on.jpg'); imagesc(bg);
                    set(ah,'handlevisibility','off','visible','off')
                    
                elseif button_state == get(hObject,'Min')
                    % button is pushed up meaning to show gray pic
                    ah = axes('Parent',echoPanel,'unit', 'normalized', 'position', [0 0 1 1]);
                    bg = imread('off.jpg'); imagesc(bg);
                    set(ah,'handlevisibility','off','visible','off')
                end
            end % end echoToggleCallBack
            
            % tremolo toggle button
            function tremoloToggleCallBack(hObject,eventdata)
                button_state = get(hObject,'Value');
                if button_state == get(hObject,'Max')
                    % button is pushed down meaning to show green pic
                    ah = axes('Parent',tremoloPanel,'unit', 'normalized', 'position', [0 0 1 1]);
                    bg = imread('on.jpg'); imagesc(bg);
                    set(ah,'handlevisibility','off','visible','off')
                    
                elseif button_state == get(hObject,'Min')
                    % button is pushed up meaning to show gray pic
                    ah = axes('Parent',tremoloPanel,'unit', 'normalized', 'position', [0 0 1 1]);
                    bg = imread('off.jpg'); imagesc(bg);
                    set(ah,'handlevisibility','off','visible','off')
                end
            end % end tremoloToggleCallBack
            
            % reverse toggle button
            function reverseToggleCallBack(hObject,eventdata)
                button_state = get(hObject,'Value');
                if button_state == get(hObject,'Max')
                    % button is pushed down meaning to show green pic
                    ah = axes('Parent',reversePanel,'unit', 'normalized', 'position', [0 0 1 1]);
                    bg = imread('on.jpg'); imagesc(bg);
                    set(ah,'handlevisibility','off','visible','off')
                    
                elseif button_state == get(hObject,'Min')
                    % button is pushed up meaning to show gray pic
                    ah = axes('Parent',reversePanel,'unit', 'normalized', 'position', [0 0 1 1]);
                    bg = imread('off.jpg'); imagesc(bg);
                    set(ah,'handlevisibility','off','visible','off')
                end
            end % end reverseToggleCallBack
            
            % Callback to name a .wav file (MenuBar)
            function wavCallback(hObject,eventdata)
                if isempty(Project.Audio2.Data) && isempty(Project.Vocal2Eff.Data) && isempty(Project.GuitarPianoEff.Data) && isempty(Project.DrumsEff.Data) && isempty(Project.Drums.Data) && isempty(Project.Vocal2.Data) && isempty(Project.GuitarPiano.Data) && isempty(Project.Audio1.Data)
                    errordlg('No Recording found','Error','modal');
                else
                    % open a new figure
                    namefig=figure('Menubar','none',...
                        'NumberTitle', 'off','Units','normalized','Position',[0.3 .5 .3 .2]);
                    set(namefig,'name','Save','windowstyle','modal');
                    nameEdit=uicontrol(namefig,'style','edit','Units','normalized','Position',[0.2 .5 .6 .18]);
                    nameText=uicontrol(namefig,'style','text','string','Save As:','Units','normalized',...
                        'Position',[0.05 .48 .15 .18],'FontSize',14,'Callback',@editwavcallback);
                    saveName=uicontrol(namefig,'style','pushbutton','Units','normalized','Position',[0.3 .2 .2 .16],...
                        'Callback',@savewavcallback,'string','Save','FontSize',12);
                    set(saveName, 'Value', 1);
                    cancelName=uicontrol(namefig,'style','pushbutton','Units','normalized','Position',[0.5 .2 .2 .16],...
                        'Callback',@cancelwavcallback,'string','Cancel','FontSize',12);
                end
            end % end wavCallback
            
            % Callback to save the named .wav file (MenuBar)
            function savewavcallback(hObject,eventdata)
                % will get the combined data from the helper function
                trackChecked(1)=get(vocals1check,'value');
                trackChecked(2)=get(vocals2check,'value');
                trackChecked(3)=get(guitarcheck,'value');
                trackChecked(4)=get(drumscheck,'value');
                trackChecked(5)=get(vocals1effcheck,'value');
                trackChecked(6)=get(vocals2effcheck,'value');
                trackChecked(7)=get(guitareffcheck,'value');
                trackChecked(8)=get(drumseffcheck,'value');
                
                indexarray=find(trackChecked==1);
                combined_data=combineData(indexarray,Project);
                
                trackName = get(nameEdit,'String');
                audiowrite([trackName '.wav'],combined_data,fs)
                namefig=gcf;
                close(namefig);
                
            end % end savewavcallback
            
            % Callback to exit figure to save a .wav file (MenuBar)
            function cancelwavcallback(hObject,eventdata)
                namefig=gcf;
                delete(namefig);
            end % end cancelwavcallback
            
            % Callback to open a new recording & window (MenuBar)
            function newRecordingCallback(hObject,eventdata)
                P=Project;
                P.runUI;
            end % end newRecordingCallback
            
            % Callback to Quit and close the figure (MenuBar)
            function QuitCallback(hObject,eventdata)
                selection = questdlg('Are you sure you want to close the window?',...
                    'Confirmation',...
                    'Close','Cancel','Close');
                switch selection,
                    case 'Close',
                        delete(f)
                    case 'Cancel'
                        return
                end
            end % end QuitCallback
            
            % Callback for the recording button
            function recordButtonCallback(hObject,eventdata)
                button_state = get(hObject,'Value');
                if button_state == get(hObject,'Max')
                    % button is pushed down -> check box property
                    CheckboxStateTRACK1(1)=get(vocals1check,'value');
                    CheckboxStateTRACK1(2)=get(vocals2check,'value');
                    CheckboxStateTRACK1(3)=get(guitarcheck,'value');
                    CheckboxStateTRACK1(4)=get(drumscheck,'value');
                    
                    if gt(sum(CheckboxStateTRACK1),1)
                        % throw error b/c multiple boxes are checked
                        errordlg('Select only one checkbox to record');
                        set(recordButton,'Value',0)
                    elseif eq(sum(CheckboxStateTRACK1),0)
                        % no boxes are checked -> throw and error
                        errordlg('Select a checkbox in Raw Recording to record');
                        set(recordButton,'Value',0)
                    else
                        % A box is checked meaning to record assign recorded data to chosen
                        % only one check box is checked so can start recording
                        % indicate that recording is happening
                        % play all the tracks
                        set(recordText,'ForegroundColor',[0.9 0 0]);
                        checkedPlots=find(CheckboxStateTRACK1==1);
                        display('Recording...');
                        % assign data to property chosen in checkbox
                        for i=1:length(checkedPlots)
                            if checkedPlots(i)==1
                                % record for vocals 1
                                cD=combineData([1 1 1 1 0 0 0 0],Project);
                                sound(cD,fs);
                                Project.Audio1.Rec.record;
                                
                            elseif checkedPlots(i)==2
                                % record for vocals 2
                                cD=combineData([1 1 1 1 0 0 0 0],Project);
                                sound(cD,fs);
                                Project.Vocal2.Rec.record;
                                
                            elseif checkedPlots(i)==3
                                % record for guitar/piano
                                cD=combineData([1 1 1 1 0 0 0 0],Project);
                                sound(cD,fs);
                                Project.GuitarPiano.Rec.record;
                                
                            elseif checkedPlots(i)==4
                                % record for drums
                                cD=combineData([1 1 1 1 0 0 0 0],Project);
                                sound(cD,fs);
                                Project.Drums.Rec.record;
                            end
                            %end
                        end
                        
                    end
                elseif button_state == get(hObject,'Min')
                    % clear any sounds
                    clear sound
                    % indicate not recording anymore
                    set(recordText,'ForegroundColor',[0.3 0.3 0.3]);
                    % button is pushed up meaning to stop recording and plot on plot that
                    % is chosen in checkbox
                    CheckboxStateTRACK1(1)=get(vocals1check,'value');
                    CheckboxStateTRACK1(2)=get(vocals2check,'value');
                    CheckboxStateTRACK1(3)=get(guitarcheck,'value');
                    CheckboxStateTRACK1(4)=get(drumscheck,'value');
                    
                    checkedPlots=find(CheckboxStateTRACK1==1);
                    
                    % display the plot
                    for i=1:length(checkedPlots)
                        display('Recording stopped...');
                        if checkedPlots(i)==1
                            % display plot for vocals 1
                            stop(Project.Audio1.Rec);
                            Project.Audio1.Data = getaudiodata(Project.Audio1.Rec);
                            plotAxes = axes('Parent',track1Panel);
                            plot1=subplot(4,1,1);
                            plot(1/fs:1/fs:length(Project.Audio1.Data)/fs,Project.Audio1.Data,'Color',[0.8 0 0])
                            ax=gca;
                            yticklabels({});
                            set(ax,'XAxisLocation','top','Color',[1 1 1],'XColor',[1 1 1],'YColor',[1 1 1],'FontName','Courier');
                            set(plot1,'Color',[0.6 0.6 0.6],'XGrid','on','GridColor',[1 1 1]);
                            set(plot1,'Position',[0.1500    0.7073    0.7750    0.20])
                            recentdata{1} = Project.Audio1.Data; %allows for effects layering
                            disp('Press Play')
                            
                        elseif checkedPlots(i)==2
                            % display plot for vocals 2
                            stop(Project.Vocal2.Rec);
                            Project.Vocal2.Data = getaudiodata(Project.Vocal2.Rec);
                            plotAxes = axes('Parent',track1Panel);
                            plot2=subplot(4,1,2);
                            plot(1/fs:1/fs:length(Project.Vocal2.Data)/fs,Project.Vocal2.Data,'Color',[0.8 0 0])
                            ax=gca;
                            yticklabels({});
                            set(ax,'XAxisLocation','top','Color',[1 1 1],'XColor',[1 1 1],'YColor',[1 1 1],'FontName','Courier');
                            set(plot2,'Color',[0.6 0.6 0.6],'XGrid','on','GridColor',[1 1 1]);
                            xticklabels({});
                            set(plot2,'Position',[0.1500    0.5073    0.7750    0.20])
                            
                            recentdata{2} = Project.Vocal2.Data; %allows for effects layering
                            disp('Press Play')
                            
                        elseif checkedPlots(i)==3
                            % display plot for guitar/piano
                            stop(Project.GuitarPiano.Rec);
                            Project.GuitarPiano.Data = getaudiodata(Project.GuitarPiano.Rec);
                            plotAxes = axes('Parent',track1Panel);
                            plot3=subplot(4,1,3);
                            plot(1/fs:1/fs:length(Project.GuitarPiano.Data)/fs,Project.GuitarPiano.Data,'Color',[0.8 0 0])
                            ax=gca;
                            yticklabels({});
                            set(ax,'XAxisLocation','top','Color',[1 1 1],'XColor',[1 1 1],'YColor',[1 1 1],'FontName','Courier');
                            set(plot3,'Color',[0.6 0.6 0.6],'XGrid','on','GridColor',[1 1 1]);
                            xticklabels({});
                            set(plot3,'Position',[0.1500    0.3073    0.7750    0.20])
                            
                            recentdata{3} = Project.GuitarPiano.Data; %allows for effects layering
                            disp('Press Play')
                            
                        elseif checkedPlots(i)==4
                            % display plot for drums
                            stop(Project.Drums.Rec);
                            Project.Drums.Data = getaudiodata(Project.Drums.Rec);
                            plotAxes = axes('Parent',track1Panel);
                            plot4=subplot(4,1,4);
                            plot(1/fs:1/fs:length(Project.Drums.Data)/fs,Project.Drums.Data,'Color',[0.8 0 0])
                            ax=gca;
                            yticklabels({});
                            set(ax,'XAxisLocation','top','Color',[1 1 1],'XColor',[1 1 1],'YColor',[1 1 1],'FontName','Courier');
                            set(plot4,'Color',[0.6 0.6 0.6],'XGrid','on','GridColor',[1 1 1]);
                            set(plot4,'Position',[0.1500    0.1073    0.7750    0.20])
                            xticklabels({});
                            recentdata{4} = Project.Drums.Data; %allows for effects layering
                            disp('Press Play')
                            
                        end
                    end
                    
                    
                end
            end % end for recordButtonCallback
            
            % Callback for the play button
            function playButtonCallback(hObject,eventdata)
                %Call helper function combineData
                trackChecked(1)=get(vocals1check,'value');
                trackChecked(2)=get(vocals2check,'value');
                trackChecked(3)=get(guitarcheck,'value');
                trackChecked(4)=get(drumscheck,'value');
                trackChecked(5)=get(vocals1effcheck,'value');
                trackChecked(6)=get(vocals2effcheck,'value');
                trackChecked(7)=get(guitareffcheck,'value');
                trackChecked(8)=get(drumseffcheck,'value');
                
                indexarray=find(trackChecked==1);
                combined_data = combineData(indexarray,Project);
                sound(combined_data, fs)
            end % end playButtonCallback
            
            % Callback for the stop button
            function stopButtonCallback(hObject,eventdata)
                clear sound
            end % end stopButtonCallback
            
            % Callback for the Clear Effects button
            function clearButtonCallback(hObject,eventdata)
                if isempty(Project.Audio2.Data) && isempty(Project.Vocal2Eff.Data) && isempty(Project.GuitarPianoEff.Data) && isempty(Project.DrumsEff.Data)
                    % if all the effects audio are empty -> return
                    return
                else
                    % redefine recentdata as the raw data
                    recentdata{1}=Project.Audio1.Data;
                    recentdata{2}=Project.Vocal2.Data;
                    recentdata{3}=Project.GuitarPiano.Data;
                    recentdata{4}=Project.Drums.Data;
                    Project.Audio2.Data=[];
                    Project.Vocal2Eff.Data=[];
                    Project.GuitarPianoEff.Data=[];
                    Project.DrumsEff.Data=[];
                    
                    % reset Track 2 figure;
                    %%%%%%%%%%%%
                    % plot new data from clear button
                    % display plot for Audio 1
                    plotAxes = axes('Parent',track2Panel);
                    plot1=subplot(4,1,1);
                    ax=gca;
                    yticklabels({});
                    set(ax,'XAxisLocation','top','Color',[1 1 1],'XColor',[1 1 1],'YColor',[1 1 1],'FontName','Courier');
                    set(plot1,'Color',[0.6 0.6 0.6],'XGrid','on','GridColor',[1 1 1]);
                    set(plot1,'Position',[0.1500    0.7073    0.7750    0.20])
                    
                    % display plot for vocals 2 Eff
                    plotAxes = axes('Parent',track2Panel);
                    plot2=subplot(4,1,2);
                    ax=gca;
                    yticklabels({});
                    set(ax,'XAxisLocation','top','Color',[1 1 1],'XColor',[1 1 1],'YColor',[1 1 1],'FontName','Courier');
                    set(plot2,'Color',[0.6 0.6 0.6],'XGrid','on','GridColor',[1 1 1]);
                    xticklabels({});
                    set(plot2,'Position',[0.1500    0.5073    0.7750    0.20])
                    
                    % display plot for guitar/piano Eff
                    plotAxes = axes('Parent',track2Panel);
                    plot3=subplot(4,1,3);
                    ax=gca;
                    yticklabels({});
                    set(ax,'XAxisLocation','top','Color',[1 1 1],'XColor',[1 1 1],'YColor',[1 1 1],'FontName','Courier');
                    set(plot3,'Color',[0.6 0.6 0.6],'XGrid','on','GridColor',[1 1 1]);
                    xticklabels({});
                    set(plot3,'Position',[0.1500    0.3073    0.7750    0.20])
                    
                    % display plot for drums
                    plotAxes = axes('Parent',track2Panel);
                    plot4=subplot(4,1,4);
                    ax=gca;
                    yticklabels({});
                    set(ax,'XAxisLocation','top','Color',[1 1 1],'XColor',[1 1 1],'YColor',[1 1 1],'FontName','Courier');
                    set(plot4,'Color',[0.6 0.6 0.6],'XGrid','on','GridColor',[1 1 1]);
                    set(plot4,'Position',[0.1500    0.1073    0.7750    0.20])
                    xticklabels({});
                end
            end % end clearButtonCallback
            
            % Callback for the Submit Effects button
            function submitButtonCallback(hObject,eventdata)
                CheckboxStateTRACK1(1)=get(vocals1check,'value');
                CheckboxStateTRACK1(2)=get(vocals2check,'value');
                CheckboxStateTRACK1(3)=get(guitarcheck,'value');
                CheckboxStateTRACK1(4)=get(drumscheck,'value');
                if eq(sum(CheckboxStateTRACK1),0)
                    return
                else
                    ON(1)=get(reverseToggle,'value');
                    ON(2)=get(tremoloToggle,'value');
                    ON(3)=get(echoToggle,'value');
                    ON(4)=get(reverbToggle,'value');
                    ON(5)=get(slowMoToggle,'value');
                    ON(6)=get(chipmunksToggle,'value');
                    checkedSubTracks=find(CheckboxStateTRACK1==1);
                    % assign data to property chosen in checkbox
                    for i=1:length(checkedSubTracks)
                        if checkedSubTracks(i)==1 %Audio2
                            if sum(ON)==0
                                return
                            else
                                numEffects=find(ON==1);
                                for j=1:length(numEffects)
                                    if numEffects(j)==1
                                        % apply Reverse
                                        Project.Audio2.Effects = Reverse(recentdata{1});
                                    elseif numEffects(j)==2
                                        % apply Tremolo
                                        Project.Audio2.Effects = Tremolo(recentdata{1});
                                    elseif numEffects(j)==3
                                        % apply Echo
                                        Project.Audio2.Effects = Echo(recentdata{1});
                                    elseif numEffects(j)==4
                                        % apply Reverb
                                        Project.Audio2.Effects = Reverb(recentdata{1});
                                    elseif numEffects(j)==5
                                        % apply SlowMo
                                        Project.Audio2.Effects = SlowMo(recentdata{1});
                                    elseif numEffects(j)==6
                                        % apply Chipmunks
                                        Project.Audio2.Effects = Chipmunks(recentdata{1});
                                    end
                                end
                            end
                            %Apply the effect as chosen above
                            Project.Audio2.Data = Project.Audio2.Effects.apply(recentdata{1});
                            recentdata{1} = Project.Audio2.Data;
                        elseif checkedSubTracks(i)==2 %Vocal2Eff
                            if sum(ON)==0
                                return
                            else
                                numEffects=find(ON==1);
                                for j=1:length(numEffects)
                                    if numEffects(j)==1
                                        Project.Vocal2Eff.Effects = Reverse(recentdata{2});
                                    elseif numEffects(j)==2
                                        Project.Vocal2Eff.Effects = Tremolo(recentdata{2});
                                    elseif numEffects(j)==3
                                        Project.Vocal2Eff.Effects = Echo(recentdata{2});
                                    elseif numEffects(j)==4
                                        Project.Vocal2Eff.Effects = Reverb(recentdata{2});
                                    elseif numEffects(j)==5
                                        Project.Vocal2Eff.Effects = SlowMo(recentdata{2});
                                    elseif numEffects(j)==6
                                        Project.Vocal2Eff.Effects = Chipmunks(recentdata{2});
                                    end
                                end
                            end
                            %Apply the effect as chosen above
                            Project.Vocal2Eff.Data = Project.Vocal2Eff.Effects.apply(recentdata{2});
                            recentdata{2} = Project.Vocal2Eff.Data;
                        elseif checkedSubTracks(i)==3 %GuitarPianoEff
                            if sum(ON)==0
                                return
                            else
                                numEffects=find(ON==1);
                                for j=1:length(numEffects)
                                    if numEffects(j)==1
                                        Project.GuitarPianoEff.Effects = Reverse(recentdata{3});
                                    elseif numEffects(j)==2
                                        Project.GuitarPianoEff.Effects = Tremolo(recentdata{3});
                                    elseif numEffects(j)==3
                                        Project.GuitarPianoEff.Effects = Echo(recentdata{3});
                                    elseif numEffects(j)==4
                                        Project.GuitarPianoEff.Effects = Reverb(recentdata{3});
                                    elseif numEffects(j)==5
                                        Project.GuitarPianoEff.Effects = SlowMo(recentdata{3});
                                    elseif numEffects(j)==6
                                        Project.GuitarPianoEff.Effects = Chipmunks(recentdata{3});
                                    end
                                end
                            end
                            %Apply the effect as chosen above
                            Project.GuitarPianoEff.Data = Project.GuitarPianoEff.Effects.apply(recentdata{3});
                            recentdata{3} = Project.GuitarPianoEff.Data;
                        elseif checkedSubTracks(i)==4 %DrumsEff
                            if sum(ON)==0
                                return
                            else
                                numEffects=find(ON==1);
                                for j=1:length(numEffects)
                                    if numEffects(j)==1
                                        Project.DrumsEff.Effects = Reverse(recentdata{4});
                                    elseif numEffects(j)==2
                                        Project.DrumsEff.Effects = Tremolo(recentdata{4});
                                    elseif numEffects(j)==3
                                        Project.DrumsEff.Effects = Echo(recentdata{4});
                                    elseif numEffects(j)==4
                                        Project.DrumsEff.Effects = Reverb(recentdata{4});
                                    elseif numEffects(j)==5
                                        Project.DrumsEff.Effects = SlowMo(recentdata{4});
                                    elseif numEffects(j)==6
                                        Project.DrumsEff.Effects = Chipmunks(recentdata{4});
                                    end
                                end
                            end
                            %Apply the effect as chosen above
                            Project.DrumsEff.Data = Project.DrumsEff.Effects.apply(recentdata{4});
                            recentdata{4} = Project.DrumsEff.Data;
                        end
                    end
                end
                
                %Plot the new data
                for i=1:length(checkedSubTracks)
                    if checkedSubTracks(i)==1
                        % display plot for vocals 1
                        plotAxes = axes('Parent',track2Panel);
                        plot1=subplot(4,1,1);
                        plot(1/fs:1/fs:length(Project.Audio2.Data)/fs,Project.Audio2.Data,'Color',[0 0 0.8])
                        ax=gca;
                        yticklabels({});
                        set(ax,'XAxisLocation','top','Color',[1 1 1],'XColor',[1 1 1],'YColor',[1 1 1],'FontName','Courier');
                        set(plot1,'Color',[0.6 0.6 0.6],'XGrid','on','GridColor',[1 1 1]);
                        set(plot1,'Position',[0.1500    0.7073    0.7750    0.20])
                        
                    elseif checkedSubTracks(i)==2
                        % display plot for vocals 2
                        plotAxes = axes('Parent',track2Panel);
                        plot2=subplot(4,1,2);
                        plot(1/fs:1/fs:length(Project.Vocal2Eff.Data)/fs,Project.Vocal2Eff.Data,'Color',[0 0 0.8])
                        ax=gca;
                        yticklabels({});
                        set(ax,'XAxisLocation','top','Color',[1 1 1],'XColor',[1 1 1],'YColor',[1 1 1],'FontName','Courier');
                        set(plot2,'Color',[0.6 0.6 0.6],'XGrid','on','GridColor',[1 1 1]);
                        xticklabels({});
                        set(plot2,'Position',[0.1500    0.5073    0.7750    0.20])
                        
                    elseif checkedSubTracks(i)==3
                        % display plot for guitar/piano
                        plotAxes = axes('Parent',track2Panel);
                        plot3=subplot(4,1,3);
                        plot(1/fs:1/fs:length(Project.GuitarPianoEff.Data)/fs,Project.GuitarPianoEff.Data,'Color',[0 0 0.8])
                        ax=gca;
                        yticklabels({});
                        set(ax,'XAxisLocation','top','Color',[1 1 1],'XColor',[1 1 1],'YColor',[1 1 1],'FontName','Courier');
                        set(plot3,'Color',[0.6 0.6 0.6],'XGrid','on','GridColor',[1 1 1]);
                        xticklabels({});
                        set(plot3,'Position',[0.1500    0.3073    0.7750    0.20])
                        
                    elseif checkedSubTracks(i)==4
                        % display plot for drums
                        plotAxes = axes('Parent',track2Panel);
                        plot4=subplot(4,1,4);
                        plot(1/fs:1/fs:length(Project.DrumsEff.Data)/fs,Project.DrumsEff.Data,'Color',[0 0 0.8])
                        ax=gca;
                        yticklabels({});
                        set(ax,'XAxisLocation','top','Color',[1 1 1],'XColor',[1 1 1],'YColor',[1 1 1],'FontName','Courier');
                        set(plot4,'Color',[0.6 0.6 0.6],'XGrid','on','GridColor',[1 1 1]);
                        set(plot4,'Position',[0.1500    0.1073    0.7750    0.20])
                        xticklabels({});
                    end
                end
            end % submitButtonCallback
            
        end
        % function runUI()
    end
    %methods
end
%classdef
