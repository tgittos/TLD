function img = tldLoadAprioriImages(tld)

files = img_dir(tld.opt.bg_img_path);
img = cell(1,length(files));
for i = 1:length(files)
    img{i} = img_alloc(files(i).name,size(tld.opt.im0.input));
end