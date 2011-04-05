function [pX,pY,pEx] = tldGeneratePositiveData_single_bbox(tld,bb0,im0,numWarps)

% TODO: remove pIdx

pX   = [];
pY   = [];
pEx  = {};

cols = bb0(1):bb0(3);
rows = bb0(2):bb0(4);

im1 = im0;

for i = 1:numWarps
    if i == 1
        pEx{i} = img_patch(im0.blur,bb0,0);
        im1.blur(rows,cols) = pEx{i};
    else
        pEx{i} = img_patch(im0.blur,bb0,1);
        im1.blur(rows,cols) = pEx{i};
    end
    pX = [pX fern(5,im1,bb0,[])];
end

pIdx = repmat(idxP,1,numWarps);
pY = ones(1,size(pX,2));