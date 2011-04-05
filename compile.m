% Compiles mex files.
clc; clear all; cd mex;

% edit based on your instalation folder
include = ' -Ic:\OpenCV2.2\include\opencv\ -Ic:\OpenCV2.2\include\';
libpath = 'C:\OpenCV2.2\lib\';

% =========================================================================

lib = [];
files = dir([libpath '*.lib']);
for i = 1:length(files)
    lib = [lib ' ' libpath files(i).name];
end
eval(['mex lk.cpp -O' include lib]);
mex -O -c tld.cpp
mex -O fern.cpp tld.obj
mex -O linkagemex.cpp  
mex -O bb_overlap.cpp  
mex -O warp.cpp        
mex -O distance.cpp    

cd ..
% clc;
disp('Compilation finished.');



