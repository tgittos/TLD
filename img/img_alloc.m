function img = img_alloc(in,imsize)
% Allocates image structure. 

if ischar(in)
    in = imread(in);
end

if ndims(in) == 3
    %img.input = in(:,:,2);
    img.input = rgb2gray(in);
    %img.input = imadjust(img.input);
else
    img.input = in;
end

% img.input = fliplr(img.input);

if exist('imsize','var')
    img.input = imresize(img.input,imsize);
end

 img.blur = img_blur(img.input,2);
%img.blur = img_blur(img.input,5);

