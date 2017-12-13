package com.mat2java.wycode;

import com.utils.wycode.Matrix;

public class p6 {
    public static void main(String[] args) {
    	String[][] a=new String[3][3];
		String[][] b=new String[3][1];
		String[][] c=new String[3][1];
		String[][] d=new String[3][3];
		
		a[0][0]="cos(t)";
		a[0][1]="sin(t)";
		a[0][2]="0";
		a[1][0]="-sin(t)";
		a[1][1]="cos(t)";
		a[1][2]="0";
		a[2][0]="0";
		a[2][1]="0";
		a[2][2]="1";
		Matrix R=new Matrix(a);
		
		
		d[0][0]="-cos(t)";
		d[0][1]="-sin(t)";
		d[0][2]="0";
		d[1][0]="sin(t)";
		d[1][1]="-cos(t)";
		d[1][2]="0";
		d[2][0]="0";
		d[2][1]="0";
		d[2][2]="-1";
		Matrix invR=new Matrix(d);
		
		b[0][0]="x";
		b[1][0]="y";
		b[2][0]="t";
		Matrix X=new Matrix(b);
		
		c[0][0]="-x";
		c[1][0]="-y";
		c[2][0]="-t";
		Matrix negX=new Matrix(c);
		
		Matrix r1=Matrix.mulMatrix(R, negX);
		
		Matrix r2=Matrix.mulMatrix(invR, X);
		
		System.out.println("R*(-X) is:");
		System.out.println(r1);
	
		System.out.println("*****************");
		System.out.println("inv(R)*X is:");
		System.out.println(r1);
		
	}
}
