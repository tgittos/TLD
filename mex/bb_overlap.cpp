#include <stdio.h>
#include <math.h>
#include <vector>
using namespace std;
#ifdef _CHAR16T
#define CHAR16_T
#endif
#include "mex.h" 


double bb_overlap(double *bb1, double *bb2) {

	if (bb1[0] > bb2[2]) { return 0.0; }
	if (bb1[1] > bb2[3]) { return 0.0; }
	if (bb1[2] < bb2[0]) { return 0.0; }
	if (bb1[3] < bb2[1]) { return 0.0; }
	
	double colInt =  min(bb1[2], bb2[2]) - max(bb1[0], bb2[0]) + 1;
	double rowInt =  min(bb1[3], bb2[3]) - max(bb1[1], bb2[1]) + 1;

	double intersection = colInt * rowInt;
	double area1 = (bb1[2]-bb1[0]+1)*(bb1[3]-bb1[1]+1);
	double area2 = (bb2[2]-bb2[0]+1)*(bb2[3]-bb2[1]+1);
	return intersection / (area1 + area2 - intersection);
}

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
	
	switch (nrhs) {

		case 0: {
			mexPrintf("bb_overlap(bb)\n");
			mexPrintf("bb_overlap(bb1,bb2)\n");
			mexPrintf("bb_overlap(bb1,bb2,1)\n");
			return;
				}

		// bb_overlap(bb), overlap matrix
		case 1: {

			// Input
			double *bb = mxGetPr(prhs[0]);
			int nBB = mxGetN(prhs[0]);
			int mBB = mxGetM(prhs[0]);

			// Output
			plhs[0] = mxCreateDoubleMatrix(1, nBB*(nBB-1)/2, mxREAL);
			double *out = mxGetPr(plhs[0]);

			for (int i = 0; i < nBB-1; i++) {
				for (int j = i+1; j < nBB; j++) {
					*out++ = bb_overlap(bb + mBB*i, bb + mBB*j);
				}
			}
			break;
				}

		// bb_overlap(bb1,bb2), overlap matrix
		case 2: {
	
			// Input
			double *bb1 = mxGetPr(prhs[0]); int M1 = mxGetM(prhs[0]); int N1 = mxGetN(prhs[0]);
			double *bb2 = mxGetPr(prhs[1]); int M2 = mxGetM(prhs[1]); int N2 = mxGetN(prhs[1]);

			// Output
            
            if (N1 == 0 || N2 == 0) {
                N1 = 0; N2 = 0;
            }
			plhs[0] = mxCreateDoubleMatrix(N1, N2, mxREAL);
			double *out = mxGetPr(plhs[0]);

			for (int j = 0; j < N2; j++) {
				for (int i = 0; i < N1; i++) {
					*out++ = bb_overlap(bb1 + M1*i, bb2 + M2*j);
				}
			}

			break;
				}

	
		case 3: {

			// bb_overlap(bb1,bb2,1), dot overlap

			// Input
			double *bb1 = mxGetPr(prhs[0]); int M1 = mxGetM(prhs[0]); int N1 = mxGetN(prhs[0]);
			double *bb2 = mxGetPr(prhs[1]); int M2 = mxGetM(prhs[1]); int N2 = mxGetN(prhs[1]);

			if (*mxGetPr(prhs[2]) == 1) {

				// Output
				plhs[0] = mxCreateDoubleMatrix(1, N1, mxREAL);
				double *out = mxGetPr(plhs[0]);

				for (int j = 0; j < N1; j++) {
					*out++ = bb_overlap(bb1 + 4*j, bb2 + 4*j);
				}
				break;

			// bb_overlap(bb1,bb2,2)
			} else { 

				// Output
				plhs[0] = mxCreateDoubleMatrix(1, N1, mxREAL);
				double *out = mxGetPr(plhs[0]);
				
	
				for (int j = 0; j < N1; j++) {
					double maxOvrlp = 0;
					for (int i = 0; i < N2; i++) {
						double overlap = bb_overlap(bb1 + M1*j, bb2 + M2*i);
						if (overlap > maxOvrlp) {
							maxOvrlp = overlap;
							out[j] = i+1.0;
						}
					}
				}
			}


				}


	}
	



}
