function bb = bb_shift_relative(bb,shift)
% Change

if isempty(bb)
    return;
end
bb(1,:) = bb(1,:) + bb_width(bb)*shift(1);
bb(2,:) = bb(2,:) + bb_height(bb)* shift(2);
bb(3,:) = bb(3,:) + bb_width(bb)*shift(1);
bb(4,:) = bb(4,:) + bb_height(bb)*shift(2);
