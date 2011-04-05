clc;
images = 'D:\_TLD_Video\bety\5272\';
% images = 'D:\PhD\Data\TLD\07_motocross\';

files = img_dir(images);
% bb = dlmread([images 'tld.txt'])';
BB = dlmread([images 'tld.txt'])';
CP = bb_center(BB);
cpold = nan;
for i = 1:length(files)
    
    img1 = imread(files(i).name);
    
    
    cp = CP(:,i);
    
    if ~isnan(cp(1))
        
        H = size(img1,1)/2;
        W = size(img1,2)/2;
        bb = [cp(1)-W/2+1, cp(2)-H/2+1, cp(1)+W/2, cp(2)+H/2]';
        %bb = bb_rescale_relative(BB(:,i),[2 2]);
        img2 = img_patch(img1,bb);
    else
        img2(:,:,:) = 0;
    end
   
    is = size(img2);
    IMG = [imresize(img1,[180 320]) imresize(img2,[180 320])];
    
    imshow(IMG);
    
    drawnow;
    end