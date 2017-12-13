package com.mat2java.wycode;

public class p8 {
    public static void main(String[] args) {
		double pCan = 0.001;
		double pNon = 0.999;
		
		String z = "positive";
		
		double pPosCan = 0.8;
		double pPosNon = 0.1;
		
		double[] p = new double[2];
		
		if(z.equals("positive")) {
			p[0] = pPosCan * pCan;
			p[1] = pPosNon * pNon;
		}
		else {
			p[0] = (1 - pPosCan) * pCan; 
			p[1] = (1 - pPosNon) * pNon;
		}
		
		double sum = p[0] + p[1];
		for(int i = 0; i < p.length; i++) {
			p[i] = p[i] / sum;
		}
		System.out.printf("The probability of having cancer given the %s test:\n", z);
		System.out.println(p[0]);
		System.out.printf("The probability of cancer free given the %s test:\n", z);		
		System.out.println(p[1]);
	}
}
