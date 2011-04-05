function tld = tldInitDetector(tld)

fern(0);
fern(1,tld.source.im0.input,tld.grid,tld.features,tld.scales);

% Variance
tld.pex    = [tld.pex tldGetPattern(tld.source.im0,tld.source.bb,tld.patchsize)];
tld.pex_conf  = 1;
tld.var    = [var(tld.pex)/2, var(tld.pex)*2];

% Fern
overlap = bb_overlap(tld.source.bb,tld.grid);

[pX,pIdx] = tldGeneratePositiveData(tld,overlap,tld.img{1},300);
pY = ones(1,size(pX,2));

[nX,nIdx] = tldGenerateNegativeData(tld,overlap,tld.img{1});
nY   = zeros(1,size(nX,2));

X = [pX nX];
Y = [pY nY];
IDX = [pIdx nIdx];
idx = randperm(size(X,2));
X = X(:,idx);
Y = Y(:,idx);
IDX = IDX(:,idx);

conf = fern(2,X,Y,1,2);

% Nearest-Neighbour
idx = Y==0 & conf >= tld.features.margin-2;
if sum(idx)==0, return; end;

nex = tldGetPattern(tld.source.im0,tld.grid(1:4,IDX(idx)),tld.patchsize);
ncc = distance(tld.pex,nex,1);

num_nex = min([length(ncc) 10]);

[sNcc sIdx] = sort(ncc,'descend');

tld.ncc = max(sNcc(1),tld.ncc);
tld.nex = nex(:,sIdx(1:num_nex));
