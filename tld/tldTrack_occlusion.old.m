function [BB2 Conf Valid] = tldTrack_occlusion(tld,BB1,I,J)

GRID      = tld.tracker.grid;
BIG_FB    = tld.tracker.big_fb;
% OCCLUSION = tld.tracker.occlusion;

BB2    = []; 
Conf   = []; 
Valid  = 0;

if isempty(BB1) || ~bb_isdef(BB1),
    return;
end

% Forward
xFI    = bb_points(BB1,GRID,GRID,5);
xFJ    = lk(2,tld.img{I}.input,tld.img{J}.input,xFI,xFI);
medFB  = median2(xFJ(3,:));
medNCC = median2(xFJ(4,:));
idxF   = xFJ(3,:) <= medFB & xFJ(4,:)>= medNCC;
[BB2,BB_shift] = bb_predict(BB1,xFI(:,idxF),xFJ(1:2,idxF));

% Failure detection
if medFB > BIG_FB || ~bb_isdef(BB2) || bb_isout(BB2,tld.imgsize)
    BB2 = [];
    return;
end

% Backward
% xBJ    = bb_points(BB2,GRID,GRID,5);
% xBI    = lk(2,tld.img{J}.input,tld.img{I}.input,xBJ,xBJ);
% medFB  = median2(xBI(3,:));
% medNCC = median2(xBI(4,:));
% idxB   = xBI(3,:) <= medFB & xBI(4,:)>= medNCC;

% Output
ex       = tldGetPattern(tld.img{J},BB2,tld.model.patchsize);
[~,Conf] = tldNN(ex,tld);
Valid    = tld.valid(I);

% Match error
% resF  = mean(vnormp(xFJ(1:2,idxF)-xBJ(:,idxF),2)); % residual of forward match
% resB  = mean(vnormp(xBI(1:2,idxB)-xFI(:,idxB),2)); % residual of backward match
% %BB_shift = vnormp(BB_shift,2);
% error = abs(resF-resB);

% if ~bb_isin(BB2,tld.imgsize) || error > OCCLUSION
%     Valid = 0;
% end

