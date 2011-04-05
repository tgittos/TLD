function [nX,nEx] = tldGenerateAprioriData(tld)

nX  = [];
nEx = [];

files = img_dir(tld.apriori);
if isempty(files), return; end

for i = 1:length(files)
    
    img = img_alloc(files(i).name);
    
    img.input = imresize(img.input,tld.imgsize);
    img.blur  = imresize(img.blur,tld.imgsize);
    
    [tnX,status] = fern(5,img,1:tld.nGrid,tld.var/2);
    nX          = [nX tnX(:,status==1)];

    idx = randvalues(1:tld.nGrid,500);
    bb  = tld.grid(1:4,idx);
    nEx = [nEx tldGetPattern(img,bb,tld.patchsize)];
    
end
