package com.mat2java.wycode;

import java.util.List;
import java.util.ArrayList;

import com.utils.wycode.*;

public class p2 {
	
   public static List<Fraction> move(List<Fraction> p,double u){
	   int n=p.size();
	   List<Fraction> q=new ArrayList<>();
	   for(int i=0;i<n;i++) {
		   if(0==i){
		   q.add(p.get(n-1));
		   }else {
			   q.add(p.get(i-1));
		   }
		   
	   }
	   return q;
   }
   public static void main(String[] args) {
	   List<Fraction> p= new ArrayList<>();
	   p.add(new Fraction(1,9));
	   p.add(new Fraction(1,3));
	   p.add(new Fraction(1,3));
	   p.add(new Fraction(1,9));
	   p.add(new Fraction(1,9));
	   
	   
	   List<Fraction> q=move(p, 1);
	   for(Fraction a:p) {
		   System.out.print(a+" ");
	   }
       System.out.println();
	   for(Fraction a:q) {
		   System.out.print(a+" ");
	   }
	 
    }
}
