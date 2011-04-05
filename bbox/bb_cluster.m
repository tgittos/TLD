function [bb,cSz] = bb_cluster(bb2, SPACE_THR, MIN_NUM_BB)
% Clusters bboxes.

if isempty(bb2)
    bb = [];
    cSz = [];
    return;
end

switch size(bb2,2)
    case 0, T = [];
    case 1, T = 1;
    case 2
        T = ones(2,1);
        if bb_distance(bb2) > SPACE_THR, T(2) = 2; end
    otherwise
        bbd = bb_distance(bb2);
        Z = linkagemex(bbd,'si');
        T = cluster(Z,'cutoff', SPACE_THR,'criterion','distance');
end
uT = unique(T);

% Merge clusters
bb = [];
cSz = [];
for i = 1:length(uT)
    num_bb = sum(T == uT(i));
    if num_bb >= MIN_NUM_BB
        bb = [bb mean(bb2(:,T == uT(i)),2)];
        cSz = [cSz num_bb];
    end
end