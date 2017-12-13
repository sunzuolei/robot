package com.mat2java.wycode;

public class p7 {
    public static void main(String[] args) {
		String[] world =  {"green" , "red" , "red", "green", "green"};
		double[] p = {0.2 ,0.2 ,0.2, 0.2 ,0.2};
		String z = "red";
		double pHit = 0.6;
		double pMiss = 0.2;
		
		double[] q = sense(p, z, world, pHit, pMiss);
    	
		for(int i = 0;i < q.length; i++) {
    		System.out.print(q[i] + " ");
    	}
		
		
	}
    
    public static double[] sense(double[] p, String z, String[] world, double pHit, double pMiss){
    	double[] q = new double[p.length];
    	double sum = 0;
    	for(int i = 0;i < q.length; i++) {
    		int hit = z.equals(world[i]) ? 1 : 0;
    		q[i] = p[i] * (hit * pHit + (1 - hit) * pMiss);
    		sum += q[i];
    	}
    	
    	for(int i = 0;i < q.length; i++) {
    		q[i] = q[i] / sum;
    	}
    	
    	return q;
    }
}