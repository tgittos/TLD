function f = tldGenerateFeatures(nTREES, nFEAT, show)

SHI = 1/5;
SCA = 1;
OFF = SHI;

x = repmat(ntuples(0:SHI:1,0:SHI:1),2,1);
x = [x x + SHI/2];
k = size(x,2);
r = x; r(3,:) = r(3,:) + (SCA*rand(1,k)+OFF);
l = x; l(3,:) = l(3,:) - (SCA*rand(1,k)+OFF);
t = x; t(4,:) = t(4,:) - (SCA*rand(1,k)+OFF);
b = x; b(4,:) = b(4,:) + (SCA*rand(1,k)+OFF);

x = [r l t b];

idx = all(x([1 2],:) < 1 & x([1 2],:) > 0,1);
x = x(:,idx);
x(x > 1) = 1;
x(x < 0) = 0;

numF = size(x,2);

x = x(:,randperm(numF));
x = x(:,1:nFEAT*nTREES);
x = reshape(x,4*nFEAT,nTREES);

f.x = x;
f.type = 'forest';

% show
if nargin == 3
if show
    for i = 1:nTREES
        F = 1+99*reshape(f.x(:,i),4,[]);
        img = zeros(100,100);
        imshow(img);
        
        line(F([1 3],:),F([2 4],:),'linewidth',1,'color','w');
        pause(.05);
    end
end
end