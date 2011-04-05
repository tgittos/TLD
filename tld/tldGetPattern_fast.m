function patt = tldGetPattern_faster(img, bbIn, patchsize)

num_bb = size(bbIn,2);
patt   = nan(prod(patchsize),num_bb);

for i = 1:num_bb
    bb = bbIn(:,i);
    cp = 0.5 * [bb(1)+bb(3); bb(2)+bb(4)]-1;
    
    sW = patchsize(1) / (bb(3)-bb(1)+1);
    sH = patchsize(2) / (bb(4)-bb(2)+1);
    
    S = [sW 0 0; 0 sH 0; 0 0 1];
    Sh = [1 0 -cp(1); 0 1 -cp(2); 0 0 1];
   
    H = S*Sh;
    
    ps2 = (patchsize(1)-1)/2;
    box = [-ps2 ps2 -ps2 ps2];
    
    patch = warp(img.blur,inv(H),box);
    
    patt(:,i) = patch(:) - mean(patch(:));
    
end