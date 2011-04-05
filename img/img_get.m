function img = img_get(source,I)

if source.camera
    img = img_alloc(getsnapshot(source.vid));
else
    img = img_alloc(source.files(source.idx(I)).name);
end
