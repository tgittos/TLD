function [oBB,oConf,oSize] = bb_cluster_confidence(iBB, iConf)
% Clusterering of tracker and detector responses
% First cluster returned corresponds to the tracker

SPACE_THR = 0.5;

oBB    = [];
oConf  = [];
oSize  = [];

if isempty(iBB)
    return;
end

switch size(iBB,2)
    case 0, T = [];
    case 1, T = 1;
    case 2
        T = ones(2,1);
        if bb_distance(iBB) > SPACE_THR, T(2) = 2; end
    otherwise
        bbd = bb_distance(iBB);
        Z = linkagemex(bbd,'si');
        T = cluster(Z,'cutoff', SPACE_THR,'criterion','distance');
end

idx_cluster  = unique(T);
num_clusters = length(idx_cluster);

oBB    = nan(4,num_clusters);
oConf  = nan(1,num_clusters);
oSize  = nan(1,num_clusters);

for i = 1:num_clusters
    
    idx = T == idx_cluster(i);
    
    oBB(:,i)  = mean(iBB(1:4,idx),2);
    oConf(i)  = mean(iConf(idx));
    oSize(i)  = sum(idx);

end

