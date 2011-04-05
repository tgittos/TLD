function bbScale = bb_scale(bb)
% Returns bbox scale = sqrt(bbox area)

bbScale = sqrt((bb(4,:)-bb(2,:)+1).*(bb(3,:)-bb(1,:)+1));

