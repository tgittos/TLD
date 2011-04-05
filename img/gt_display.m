path = 'X:\PhD\Publications\2009-06_OLCV2009\Web\MultiFace\';
clf;
files = img_dir(path);
load([path 'gt.mat']);
for i = 1:length(files)
    img =  imread([path files(i).name]);
    for ii = 1:length(gt)
        img = bb_burn(img,gt{ii}.bb(:,1763+i),255);
    end
    imshow(img);
    drawnow;
end