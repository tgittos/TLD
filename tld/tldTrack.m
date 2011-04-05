function [BB2 Conf Valid] = tldTrack(tld,BB1,I,J)

GRID   = 10;
BIG_FB = 10;

BB2    = []; 
Conf   = []; 
Valid  = 0;

if isempty(BB1) || ~bb_isdef(BB1),
    return;
end

% Tracking
ptI    = bb_points(BB1,GRID,GRID,5);
ptJ    = lk(2,tld.img{I}.input,tld.img{J}.input,ptI,ptI);
medNCC = median2(ptJ(4,:));
idx = ptJ(4,:) > medNCC;
medFB  = median2(ptJ(3,idx));

idx    = ptJ(3,:) < medFB & ptJ(4,:)> medNCC;
BB     = bb_predict(BB1,ptI(:,idx),ptJ(1:2,idx));

% Failure detection
if medFB > BIG_FB || ~bb_isdef(BB) || bb_isout(BB,tld.imgsize)
    return;
end

% Output
BB2   = BB;
ex    = tldGetPattern(tld.img{J},BB2,tld.model.patchsize);
Conf  = tldNN(ex,tld);
Valid = tld.valid(I);
if ~bb_isin(BB,tld.imgsize)
    Valid = 0;
end