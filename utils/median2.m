function m = median2(x)
% Median without nan

x(isnan(x)) = [];
m = median(x);
