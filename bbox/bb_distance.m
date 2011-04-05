function d = bb_distance(bb1,bb2)
% Info

switch nargin
    case 1 
        d = 1 - bb_overlap(bb1);
    case 2
        d = 1 - bb_overlap(bb1,bb2);
end