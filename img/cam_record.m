for i = 1:1000
   img = getsnapshot(vid);
   imshow(img,[]);

   imwrite(img,[n2s(i,5) '.jpg'],'jpeg');
      drawnow;
end