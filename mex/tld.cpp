void iimg(unsigned char *in, double *ii, int imH, int imW) {

	double *prev_line = ii;
	double s;

	*ii++ = *in++;

	for (int x = 1; x < imH; x++) {
		*ii = *in + *(ii-1);
		ii++; in++;
	}

	for (int y = 1; y < imW; y++) {
		s = 0;
		for (int x = 0; x < imH; x++) {
			s += *in;
			*ii = s + *prev_line;
			ii++; in++; prev_line++;
		}
	}
}


void iimg2(unsigned char *in, double *ii2, int imH, int imW) {

	double *prev_line = ii2;
	double s;

	*ii2++ = (*in)*(*in); in++;

	for (int x = 1; x < imH; x++) {
		*ii2 = (*in)*(*in) + *(ii2-1);
		ii2++; in++;
	}

	for (int y = 1; y < imW; y++) {
		s = 0;
		for (int x = 0; x < imH; x++) {
			s += *in * *in;
			*ii2 = s + *prev_line;
			ii2++; in++; prev_line++;
		}
	}

}


double bbox_var_offset(double *ii,double *ii2, int *off) {
	// off[0-3] corners of bbox, off[4] area
	double mX  = (ii[off[3]] - ii[off[2]] - ii[off[1]] + ii[off[0]]) / (double) off[4];
	double mX2 = (ii2[off[3]] - ii2[off[2]] - ii2[off[1]] + ii2[off[0]]) / (double) off[4];
	return mX2 - mX*mX;
}

