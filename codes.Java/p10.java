package com.mat2java.wycode;

import Jama.Matrix;

public class p10 {
    public static void main(String[] args) {
		String[][] world = {{"red","green","green","red","red"},
				            {"red","red","green","red","red"},
				            {"red","red","green","green","red"},
				            {"red","red","red","red","red"}};
		
		int nRow = world.length;
		int nCol = world[0].length;
		
		double pStart = 0.7;
		double[][] p = new double[nRow][nCol];
		for(int i = 0; i < nRow; i++) {
			for(int j = 0; j < nCol; j++) {
				p[i][j] = (1 - pStart) / (nRow * nCol - 1);
			}
		}
		p[2][1] = pStart;
		
		int[] stop = {0, 0};
		int[] right = {0, 1};
		int[] left = {0, -1};
		int[] down = {1, 0};
		int[] up = {-1, 0};
		
		double pMoveCorrect = 0.8;
		double[][] q = move1(p, right, pMoveCorrect);
		for(int i = 0; i < q.length; i++) {
			for(int j = 0; j < q[0].length; j++) {
				System.out.printf("%1.4f%s", p[i][j], " " );
			}
			System.out.println();
		}
	}
    
    public static double[][] move1(double[][] p, int[] u, double pMoveCorrect){
    	int nRow = p.length;
    	int nCol = p[0].length;
    	
    	double[][] q = new double[nRow][nCol];
    	
    	for(int i = 0; i < nRow; i++) {
    		for(int j = 0; j < nCol; j++ ) {
    			q[i][j] = pMoveCorrect * p[(i - 1 - u[0]) % nRow + 1][(j - 1 - u[1]) / nCol + 1] + (1 - pMoveCorrect) * p[i][j];
    		}
    	}
    	return q;
    }
}
