function HELPERPLOT(project,indarray,track1Panel,fs,importData)
if indarray==1
    % vocals 2
    plotAxes = axes('Parent',track1Panel);
    plot1=subplot(4,1,1);
    plot(1/fs:1/fs:length(importData)/fs,importData,'Color',[0 0 0.8])
    ax=gca;
    yticklabels({});
    set(ax,'XAxisLocation','top','Color',[1 1 1],'XColor',[1 1 1],'YColor',[1 1 1],'FontName','Courier');
    set(plot1,'Color',[0.6 0.6 0.6],'XGrid','on','GridColor',[1 1 1]);
    set(plot1,'Position',[0.1500    0.7073    0.7750    0.20])
    
elseif indarray==2
    % vocals 2
    plotAxes = axes('Parent',track1Panel);
    plot2=subplot(4,1,2);
    plot(1/fs:1/fs:length(importData)/fs,importData,'Color',[0 0 0.8])
    ax=gca;
    yticklabels({});
    set(ax,'XAxisLocation','top','Color',[1 1 1],'XColor',[1 1 1],'YColor',[1 1 1],'FontName','Courier');
    set(plot2,'Color',[0.6 0.6 0.6],'XGrid','on','GridColor',[1 1 1]);
    xticklabels({});
    set(plot2,'Position',[0.1500    0.5073    0.7750    0.20])
    
elseif indarray==3
    %guitar/piano
    plotAxes = axes('Parent',track1Panel);
    plot3=subplot(4,1,3);
    plot(1/fs:1/fs:length(importData)/fs,importData,'Color',[0 0 0.8])
    ax=gca;
    yticklabels({});
    set(ax,'XAxisLocation','top','Color',[1 1 1],'XColor',[1 1 1],'YColor',[1 1 1],'FontName','Courier');
    set(plot3,'Color',[0.6 0.6 0.6],'XGrid','on','GridColor',[1 1 1]);
    xticklabels({});
    set(plot3,'Position',[0.1500    0.3073    0.7750    0.20])
    
elseif indarray==4
    % drums
    plotAxes = axes('Parent',track1Panel);
    plot4=subplot(4,1,4);
    plot(1/fs:1/fs:length(importData)/fs,importData,'Color',[0 0 0.8])
    ax=gca;
    yticklabels({});
    set(ax,'XAxisLocation','top','Color',[1 1 1],'XColor',[1 1 1],'YColor',[1 1 1],'FontName','Courier');
    set(plot4,'Color',[0.6 0.6 0.6],'XGrid','on','GridColor',[1 1 1]);
    set(plot4,'Position',[0.1500    0.1073    0.7750    0.20])
    xticklabels({});
    
end

end