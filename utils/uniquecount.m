function out = uniquecount(in)
% Replaces value with number of occurences.

uin = unique(in);
out = in;
for i = 1:length(uin)
    
    id = in == uin(i);
    out(id) = sum(id);
end

    