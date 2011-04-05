function bb = bb_click(tld,img)
% Create

if isfield(tld,'handle')
     h = get(gca,'Children'); delete(h(1:end-1));
    set(tld.handle,'cdata',img);
else
    imshow(img);
end
text(10,10,'Define bounding box and double click inside.','color','white');
h = imrect;
p = wait(h);
bb = [p(1); p(2);p(1)+p(3); p(2)+p(4)];
% [c,r,p] = impixel(img);
% if length(c) ~= 2,
%     bb = [];
%     return;
% end
% bb = [c(1); r(1); c(2); r(2)];