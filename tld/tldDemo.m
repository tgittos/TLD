function tldDemo(opt)

global tld; % holds all tracking results

select_source = 1;
initialize    = 1;
quit_tld      = 0;

while 1
    
    % select data source --------------------------------------------------
    if select_source
        opt.source = tldInitSource(opt.source);
        select_source = 0;
        initialize    = 1;
        tld           = [];
    end
    
    
    % open figure for display of results ----------------------------------
    figure(2); set(2,'KeyPressFcn', @handleKey);
    
    
    % initialize TLD in the first frame -----------------------------------
    if initialize
        % get initial frame and initial bounding box
        while 1
            source = tldInitFirstFrame(tld,opt.source,opt.model.min_win);
            if ~isempty(source),
                opt.source = source;
                break;
            end
        end
        % train initial detector
        tld = tldInit(opt,tld);
        % display first frame
        tld = tldDisplay(0,tld);
        initialize = 0;
    end
    
    
    % saves the first frame to memory or on hard drive --------------------
    switch tld.plot.save
        case 2
            tld.snapshot{1} = getframe;
        case 1
            img = getframe;
            imwrite(img.cdata,[tld.name num2str(1,'%05d') '.png']);
    end
    
    
    for i = 2:length(tld.source.idx)
        
        % TLD =======================
        tld = tldProcessFrame(tld,i);
        tldDisplay(1,tld,i);
        % ===========================
        
        if mod(i,200) == 0
            try
                print(gcf,'-r0','-dpng',[tld.name datestr(now,30) '.png']);
            catch
                disp('not saved');
            end
        end
        
        if quit_tld
            if tld.source.camera
                stoppreview(tld.source.vid);
                closepreview(tld.source.vid);
            end
            close(2); close(1);
            return;
        end
        
        if select_source
            if tld.source.camera
                stoppreview(tld.source.vid);
                closepreview(tld.source.vid);
            end
            close(2);
            break;
        end
        
        if initialize
            break;
        end
        
        if tld.plot.save == 2
            tld.snapshot{i} = getframe;
        end
        if tld.plot.save == 1
            img = getframe;
            imwrite(img.cdata,[tld.name num2str(i,'%05d') '.png']);
        end
        
    end
    
    disp(round([1:i;tld.bb(:,1:i)])');
    if tld.control.repeat == 0;
        return;
    end
    tld.bb(:,2:end) = nan;
    tld.conf(:) = nan;
    tld.valid(:)= nan;
    tld.trackerfailure(:) = nan;
    
end % end while 1

    function handleKey(~, evnt)
        switch evnt.Character
            case '1'
                tld.control.maxbbox = 0.2;
                tld.control.update_detector = 0;
            case '2'
                tld.control.maxbbox = 1;
                tld.control.update_detector = 1;
            case '3'
                tld.control.maxbbox = 1;
                tld.control.update_detector = 1;
                tld.model.fliplr = 1;
            case 'c'
                tld.plot.confidence = 1 - tld.plot.confidence;
            case 'q'
                quit_tld = 1;
            case 's'
                select_source = 1;
                opt.source.id = [];
            case 'i'
                initialize = 1;
                if opt.source.id>0
                    opt.source.bb0{opt.source.id} = [];
                end
            case 'd'
                tld.plot.dt =  1 - tld.plot.dt;
            case '#'
                tld.plot.draw = 1 - tld.plot.draw;
            case 'p'
                tld.plot.pex = 1 - tld.plot.pex;
            case 'n'
                tld.plot.nex = 1 - tld.plot.nex;
            case '-'
                tld.control.maxbbox = tld.control.maxbbox - 0.05;
            case '='
                tld.control.maxbbox = tld.control.maxbbox + 0.05;
            case 't'
                tld.plot.target = 1 - tld.plot.target;
            case 'r'
                tld.plot.replace = 1 - tld.plot.replace;
            case 'f'
                tld.model.fliplr = 1 - tld.model.fliplr;
            case 'o'
                tld.plot.drawoutput = tld.plot.drawoutput + 1;
                if tld.plot.drawoutput > 3
                    tld.plot.drawoutput = 0;
                end
            case ' '
                print(gcf,'-r0','-dpng',[tld.name datestr(now,30) '.png']);
            case '.'
                tld.plot.pts = 1 - tld.plot.pts;
            case 'h'
                tld.plot.help = 1 - tld.plot.help;
            case ']'
                tld.control.rescale = tld.control.rescale*1.1;
            case '['
                tld.control.rescale = tld.control.rescale/1.1;
                
        end
    end
end
