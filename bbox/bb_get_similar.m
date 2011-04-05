function [bb idx] = bb_get_similar(bb0,bb1,thr)

idx = find(bb_overlap(bb1(1:4,:),bb0)>thr);
bb  = bb1(:,idx);