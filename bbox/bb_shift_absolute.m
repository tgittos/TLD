function bb = bb_shift_absolute(bb,shift)
% Change

bb(1,:) = bb(1,:) + shift(1);
bb(2,:) = bb(2,:) + shift(2);
bb(3,:) = bb(3,:) + shift(1);
bb(4,:) = bb(4,:) + shift(2);
