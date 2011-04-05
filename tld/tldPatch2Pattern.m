function pattern = tldPatch2Pattern(patch,patchsize)

patch   = imresize(patch,patchsize); % 'bilinear' is faster
pattern = double(patch(:));
pattern = pattern - mean(pattern);