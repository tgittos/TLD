function [nX,nEx] = tldGenerateNegativeData(tld,overlap,img)

% Measure patterns on all bboxes that are far from initial bbox

idxN        = find(overlap<tld.n_par.overlap);
[nX,status] = fern(5,img,idxN,tld.var/2);
idxN        = idxN(status==1); % bboxes far and with big variance
nX          = nX(:,status==1);

% Randomly select 'num_patches' bboxes and measure patches
idx = randvalues(1:length(idxN),tld.n_par.num_patches);
bb  = tld.grid(:,idxN(idx));
nEx = tldGetPattern(img,bb,tld.model.patchsize);