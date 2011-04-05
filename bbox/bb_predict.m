function [BB1 shift] = bb_predict(BB0,pt0,pt1)

of  = pt1 - pt0;
dx  = median(of(1,:));
dy  = median(of(2,:));

d1  = pdist(pt0','euclidean');
d2  = pdist(pt1','euclidean');
s   = median(d2./d1);

s1  = 0.5*(s-1)*bb_width(BB0);
s2  = 0.5*(s-1)*bb_height(BB0);

BB1  = [BB0(1)-s1; BB0(2)-s2; BB0(3)+s1; BB0(4)+s2] + [dx; dy; dx; dy];
shift = [s1; s2];
