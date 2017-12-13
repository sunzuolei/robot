package com.mat2java.wycode;

import java.util.ArrayList;
import java.util.List;

public class p3 {
  public static Double compMean(List<Double> x) {
	  Double s=new Double(0);
	  for(Double t:x) {
		  s=Double.sum(s, t);
	  }
	  return s/x.size();
  }
  
  public static Double compVariance(List< Double> x) {
	  Double mu=compMean(x);
	  List<Double> x2=new ArrayList<>();
	  //Double[] x2=new Double[x.size()];
	  
	  for(int i=0;i<x.size();i++) {
		  x2.add((x.get(i)-mu)*(x.get(i)-mu));
	  }
	  
	  return compMean(x2);
  }
  
  public static void main(String[] args) {
	  List<Double> x=new ArrayList<>();
	  
	  x.add(new Double(7));
	  x.add(new Double(38));
	  x.add(new Double(4));
	  x.add(new Double(23));
	  x.add(new Double(18));

	  System.out.printf("The Expectation / Mean: \t %.1f \n",compMean(x));
	  System.out.printf("The Variance is:\t\t %.1f \n",compVariance(x));
	  System.out.printf("The Standard Deviation is:\t %.1f \n",Math.sqrt(compVariance(x)));
	  
  }
}
