function images = img_dir(path)
% Looks into 'path' directory and returns a list of images in it

% considered extensions
ext = {'*.jpeg','*.jpg','*.png','*.pgm'};

images = [];
for i = 1:length(ext)
    images = [images dir([path ext{i}])];
end

% images are returned with absolute path
for i = 1:length(images)
    images(i).name = [path images(i).name];
end
