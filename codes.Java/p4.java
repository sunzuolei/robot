package com.mat2java.wycode;

import java.util.ArrayList;
import java.util.List;

public class p4 {
	 public static Double compMean(List<Double> x) {
		  Double s=new Double(0);
		  for(Double t:x) {
			  s=Double.sum(s, t);
		  }
		  return s/x.size();
	  }
	  

	  
	  public static void main(String[] args) {
	    double a=2;
	    double b=4;
	    
		  List<Double> x=new ArrayList<>();
		  
		  x.add(new Double(7));
		  x.add(new Double(38));
		  x.add(new Double(4));
		  x.add(new Double(23));
		  x.add(new Double(18));
		  
		  List<Double> y=new ArrayList<>();
		  for(int i=0;i<x.size();i++) {
		     y.add(x.get(i)*a+b);	  
		  }
		  
		  Double xmu=compMean(x);
		  Double ymu=compMean(y);
		  
		  
		  System.out.printf("a * Xmu + b \t= %.2f \n",a*xmu+b);
		  System.out.printf("Ymu \t\t= %.2f \n",ymu);
		  
		 
	  }
}
