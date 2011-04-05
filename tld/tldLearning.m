function tld = tldLearning(tld,I)

bb    = tld.bb(:,I); % current bounding box
img   = tld.img{I}; % current image

% Check consistency -------------------------------------------------------

pPatt  = tldGetPattern(img,bb,tld.model.patchsize); % get current patch
[pConf1,~,pIsin] = tldNN(pPatt,tld); % measure similarity to model

if pConf1 < 0.5, disp('Fast change.'); tld.valid(I) = 0; return; end % too fast change of appearance
if var(pPatt) < tld.var, disp('Low variance.'); tld.valid(I) = 0; return; end % too low variance of the patch
if pIsin(3) == 1, disp('In negative data.'); tld.valid(I) = 0; return; end % patch is in negative data

% Update ------------------------------------------------------------------

% generate positive data
overlap  = bb_overlap(bb,tld.grid); % measure overlap of the current bounding box with the bounding boxes on the grid
[pX,pEx] = tldGeneratePositiveData(tld,overlap,img,tld.p_par_update); % generate positive examples from all bounding boxes that are highly overlappipng with current bounding box
pY       = ones(1,size(pX,2)); % labels of the positive patches

% generate negative data
idx      = overlap < tld.n_par.overlap & tld.tmp.conf >= 1; % get indexes of negative bounding boxes on the grid (bounding boxes on the grid that are far from current bounding box and which confidence was larger than 0)
overlap  = bb_overlap(bb,tld.dt{I}.bb); % measure overlap of the current bounding box with detections
nEx      = tld.dt{I}.patch(:,overlap < tld.n_par.overlap); % get negative patches that are far from current bounding box

fern(2,[pX tld.tmp.patt(:,idx)],[pY zeros(1,sum(idx))],tld.model.thr_fern,2); % update the Ensemble Classifier (reuses the computation made by detector)
tld = tldTrainNN(pEx,nEx,tld); % update nearest neighbour 


