function source = tldInitSource(source)
% Initializes video stream from camera or an image sequence.

% Video stream
if source.camera
    initcamera;
    source.idx    = 1:10000; 
    
% Image sequence    
else
    source.files  = img_dir(source.input);
    source.idx    = 1:length(source.files);
end