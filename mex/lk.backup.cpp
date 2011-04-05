#include "mex.h" 
#include "cv.h"
#include "highgui.h"

IplImage *grey1 = 0, *grey0 = 0, *pyramid1 = 0, *pyramid0 = 0;

int win_size = 5;
CvPoint2D32f* points[2] = {0,0};

void loadImageFromMatlab(const mxArray *mxImage, IplImage *image) {

    unsigned char *values =  (unsigned char *) mxGetPr(mxImage);
	int widthStep = image->widthStep;
	int N = mxGetN(mxImage); // width
    int M = mxGetM(mxImage); // height
    
    for(int i=0;i<N;i++)
       for(int j=0;j<M;j++) 
            image->imageData[j*widthStep+i] = values[j+i*M];
}


void mexFunction(int plhs_size, mxArray *plhs[], int prhs_size, const mxArray *prhs[])
{
	// Load images

	if (prhs_size ==4) {
		win_size = *mxGetPr(prhs[3]);
	}
	
    int N = mxGetN(prhs[0]); 
    int M = mxGetM(prhs[0]); 
	grey0 = cvCreateImage( cvSize(N, M), 8, 1 );
	grey1 = cvCreateImage( cvSize(N, M), 8, 1 );
	loadImageFromMatlab(prhs[0],grey0);
	loadImageFromMatlab(prhs[1],grey1);

	// Load feature points
	double *fp = mxGetPr(prhs[2]);
	
	int num_pts = mxGetN(prhs[2]);
	points[0] = (CvPoint2D32f*)cvAlloc(num_pts*sizeof(points[0][0]));
	points[1] = (CvPoint2D32f*)cvAlloc(num_pts*sizeof(points[0][0]));
	char *status = (char*)cvAlloc(num_pts);
	float *error = (float*) cvAlloc(num_pts*sizeof(float));
	for (int i = 0; i < num_pts; i++) {
		points[0][i].x = fp[2*i];
		points[0][i].y = fp[2*i+1];
	}
	// neni treba, urychleni z fpt 40 -> fps 200
	//cvFindCornerSubPix( grey0, points[0], num_pts, cvSize(win_size,win_size), cvSize(-1,-1), cvTermCriteria(CV_TERMCRIT_ITER|CV_TERMCRIT_EPS,20,0.03));

	pyramid1 = cvCreateImage( cvGetSize(grey1), 8, 1 );
	pyramid0 = cvCreateImage( cvGetSize(grey1), 8, 1 );
	
	cvCalcOpticalFlowPyrLK( grey0, grey1, pyramid0, pyramid1, points[0], points[1], num_pts, cvSize(win_size,win_size), 6, status, error, cvTermCriteria(CV_TERMCRIT_ITER|CV_TERMCRIT_EPS,20,0.03), 0 );

	// Output
    
	plhs[0] = mxCreateDoubleMatrix(6, num_pts, mxREAL);
	double *output = mxGetPr(plhs[0]);
	for (int i = 0; i < num_pts; i++) {
		output[6*i]   = (double) points[0][i].x;
		output[6*i+1] = (double) points[0][i].y;
		output[6*i+2] = (double) points[1][i].x;
		output[6*i+3] = (double) points[1][i].y;
		output[6*i+4] = (double) error[i];
        output[6*i+5] = (double) status[i];

		//output[5*i+5] = (double) error[i];
	}

	// Tidy up
	cvReleaseImage( &pyramid0 );
	cvReleaseImage( &pyramid1 );
    cvReleaseImage( &grey0 );
	cvReleaseImage( &grey1 );
    return;
}

