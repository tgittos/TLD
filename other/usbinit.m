% webcam init
% global vid;
vid = videoinput('winvideo', 1,'RGB24_320x240');
set(vid,'returnedcolorspace','grayscale')
info = imaqhwinfo('winvideo');
preview(vid);
ss = getselectedsource(vid);
ss.Backlightcompensation = 'off';
ss.WhiteBalanceMode = 'manual';