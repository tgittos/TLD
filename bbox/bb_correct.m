function bb = bb_correct(img,bb)
% Change

K  = 2;
K2 = 1;
while 1

    clf; imshow(img); bb_rectangle(bb,'EdgeColor','y');
    %maximize();
    [x,y,ch] = ginput(1);
    if isempty(ch), break; end
    switch ch
        case 29 
            bb = [bb(1)+K; bb(2); bb(3)+K; bb(4)];
        case 28
            bb = [bb(1)-K; bb(2); bb(3)-K; bb(4)];
        case 30
            bb = [bb(1); bb(2)-K; bb(3); bb(4)-K];
        case 31
            bb = [bb(1); bb(2)+K; bb(3); bb(4)+K];
        case 46 % bigger
            bb = [bb(1)-K2; bb(2)-K2; bb(3)+K2; bb(4)+K2];
        case 44 % smaller
            bb = [bb(1)+K2; bb(2)+K2; bb(3)-K2; bb(4)-K2];
            
    end
    
end