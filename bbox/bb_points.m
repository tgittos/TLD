function pt = bb_points(bb,numM,numN,margin)
% Generates numM x numN points on BBox.

bb(1:2) = bb(1:2)+margin;
bb(3:4) = bb(3:4)-margin;

if (numM == 1 && numN ==1)
    pt = bb_center(bb);
    return;
end

if (numM == 1 && numN > 1)
    c = bb_center(bb);
    stepW = (bb(3)-bb(1)) / (numN - 1);
    pt = ntuples(bb(1):stepW:bb(3),c(2));
    return;
end

if (numM > 1 && numN == 1)
    c = bb_center(bb);
    stepH = (bb(4)-bb(2)) / (numM - 1);
    pt = ntuples(c(1),(bb(2):stepH:bb(4)));
    return;
end
    
stepW = (bb(3)-bb(1)) / (numN - 1);
stepH = (bb(4)-bb(2)) / (numM - 1);

pt = ntuples(bb(1):stepW:bb(3),(bb(2):stepH:bb(4)));

