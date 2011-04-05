TLD v1.0
========

TLD is an algorithm for tracking of unknown objects in unconstrained video streams.
The object of interest is defined by a bounding box in a single frame. TLD simulta-
neously tracks the object, learns its appearance and detects it whenever it appears
in the video. The result is a real-time tracking that typically improves over time.

Licence
=======

You are allowed to use TLD under the terms of the GPL v2.0. It means that any 
distributed project that includes or links any portion of TLD source code should be
released with the source code under the GPL v2.0 licence or above. The details of 
the license can be found in LICENCE.txt. If these terms do not meet your requirements, 
contact zdene.kalal@gmail.com

Please cite our CVPR'10 paper if you use the code for academic purposes.
  @article{Kalal2010,
     author = {Kalal, Z and Matas, J and Mikolajczyk, K},
     journal = {Conference on Computer Vision and Pattern Recognition},
     title = {{P-N Learning: Bootstrapping Binary Classifiers by Structural Constraints}},
     year = {2010}
  }               

INSTALATION
===========

1. Compile mex files: edit and execute "compile.m"
   Requires: OpenCV
   Tested using MS Visual Studio 2010 compiler and OpenCV2.2
2. Execute "run_TLD.m" with default parameters. The TLD should track a motorbike
   from "_input" and store the results to "_output".



   

