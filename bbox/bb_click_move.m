function bb = bb_click_move(img,bb)
% Change

[c,r,p] = impixel(bb_burn(img,bb));

bbW = bb_width(bb);
bbH = bb_height(bb);

bb = [c(1) - bbW/2; r(1) - bbH/2; c(1) + bbW/2; r(1) + bbH/2];
