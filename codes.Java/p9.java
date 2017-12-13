package com.mat2java.wycode;

import Jama.Matrix;

public class p9 {
    public static void main(String[] args) {
		double a = 1, b = 2, c = 3, d = 4, e = 5, f = 6, g = 7;
		
		
		double[][] mu1 = {{a},{b}};
		Matrix mu = new Matrix(mu1);

        double[][] invSigma1 = {{c,d},{d,e}};
		Matrix invSigma = new Matrix(invSigma1);

		
		double[][] x1 = {{f},{g}};

		Matrix x = new Matrix(x1);


		mu.transpose().times(invSigma).times(x).print(3, 2);
		x.transpose().times(invSigma).times(mu).print(3, 2);;
		

	}
}
