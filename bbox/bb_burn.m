function img = bb_burn(img, bb_in, width)

if ~exist('width','var')
    width = 0;
end

if isempty(bb_in)
    return;
end

for i = 1:size(bb_in,2)

    bb = bb_in(:,i);
    bb(1) = max([1 bb(1)]);
    bb(2) = max([1 bb(2)]);
    bb(3) = min([size(img,2), bb(3)]);
    bb(4) = min([size(img,1), bb(4)]);

    
    img(bb(2):bb(2)+width,bb(1):bb(3)) = 255;
    img(bb(4)-width:bb(4),bb(1):bb(3)) = 255;
    img(bb(2):bb(4),bb(1):bb(1)+width) = 255;
    img(bb(2):bb(4),bb(3)-width:bb(3)) = 255;
    
end