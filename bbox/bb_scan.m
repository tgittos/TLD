function [bb_out,sca] = bb_scan(bb, imsize,min_win)

SHIFT = 0.1;
SCALE = 1.2.^[-10:10];
MINBB = min_win;

% Chack if input bbox is smaller than minimum
if min(bb_size(bb)) < MINBB
    bb_out = [];
    sca    = [];
    return;
end

bbW   = round(bb_width(bb) .* SCALE);
bbH   = round(bb_height(bb) .* SCALE);
bbSHH = SHIFT * min(bbH,bbH);
bbSHW = SHIFT * min(bbH,bbW);

bbF   = [2 2 imsize(2) imsize(1)]';

bbs = {};
sca = [];
idx = 1;

for i = 1:length(SCALE)
    if bbW(i) < MINBB || bbH(i) < MINBB, continue; end
    
    left  = round(bbF(1):bbSHW(i):bbF(3)-bbW(i)-1);
    top   = round(bbF(2):bbSHH(i):bbF(4)-bbH(i)-1);
    
    grid  = ntuples(top,left);
    if isempty(grid), continue; end
    
    bbs{end+1} =  [grid(2,:); ...
        grid(1,:); ...
        grid(2,:)+bbW(i)-1; ...
        grid(1,:)+bbH(i)-1; ...
        idx*ones(1,size(grid,2));
        length(left)*ones(1,size(grid,2));];
    sca  = [sca [bbH(i); bbW(i)]];
    idx = idx + 1;
end
bb_out = [];
for i = 1:length(bbs)
    bb_out = [bb_out bbs{i}];
end

% for i = 1:length(bbs)
%     
%     if i-1 > 0
%         idx = bb_overlap(bbs{i},bbs{i-1},2);
%         bbs{i}(7,:) = idx;
%     end
%     
%     if i+1 <= length(bbs)
%         idx = bb_overlap(bbs{i},bbs{i+1},2);
%         bbs{i}(8,:) = idx;
%     end
%     
% end
% disp(['MINBB: ' num2str(MINBB) ', bb: ' num2str(size(bbs,2))]);
% end


