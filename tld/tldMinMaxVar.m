function [minmax] = tldMinMaxVar(Var)

K = 2;
minmax(1) = min(Var) / K;
minmax(2) = max(Var) * K;
minmax(2) = Inf;