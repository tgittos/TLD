function bb2 = bb_square(bb1)
% Makes all bboxes square with the same area.

if isempty(bb1);
    bb2 = [];
    return;
end

S = bb_scale(bb1);
C = bb_center(bb1);

bb2 = [C(1,:) - S/2; C(2,:) - S/2; C(1,:) + S/2; C(2,:) + S/2];
