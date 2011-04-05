function id = idx2id(idx,N)

id = zeros(1,N); 
id(idx) = 1;
id = logical(id);