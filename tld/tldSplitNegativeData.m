function [nX1,nX2,nEx1,nEx2] = tldSplitNegativeData(nX,nEx)
% Splits negative data to training and validation set

N    = size(nX,2);
idx  = randperm(N);
nX   = nX(:,idx);
nX1  = nX(:,1:N/2); 
nX2  = nX(:,N/2+1:end); 

N    = size(nEx,2);
idx  = randperm(N);
nEx  = nEx(:,idx);
nEx1 = nEx(:,1:N/2); 
nEx2 = nEx(:,N/2+1:end);