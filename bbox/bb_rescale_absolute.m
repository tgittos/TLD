function bb = bb_rescale_absolute(bb,row,col)
% Change

bb(1) = bb(1) - col;
bb(2) = bb(2) - row;
bb(3) = bb(3) + col;
bb(4) = bb(4) + row;