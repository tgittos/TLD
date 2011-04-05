#include <stdio.h>
#include "mex.h"
#include "tld.h"

/* Integral image, requires uint8 at the input*/
/* input uint8, output double */
/* example: out = ii(in) */

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
	if (nrhs != 1 && nrhs !=	2) {
		mexPrintf("ii: wrong input.\n");
		return;
	}
	
	// Input
	unsigned char *in = (unsigned char *) mxGetPr(prhs[0]);
	int imH = mxGetM(prhs[0]);
	int imW = mxGetN(prhs[0]);

	// Output
	double *ii;
	if (nrhs==1) {
		plhs[0] = mxCreateDoubleMatrix(imH, imW, mxREAL);
		ii = mxGetPr(plhs[0]);
	} else {
		ii = mxGetPr(prhs[1]);
	}

	iimg(in,ii,imH,imW);
}
