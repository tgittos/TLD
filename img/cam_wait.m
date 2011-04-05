function img = cam_wait(T,BB)
% Runs cam for T sec. and returns the last frame.

global vid;
tic;
while toc < T
    img = img_alloc(getsnapshot(vid));
    imshow(img.in);
    if exist('BB','var')
        bb_draw(BB,'EdgeColor','y','LineWidth',3); 
        %title(toc); 
        drawnow;
    end
end
