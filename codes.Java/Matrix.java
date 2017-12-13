package com.utils.wycode;

public class Matrix {
	private String[][] m;
	private int row;
	private int column;
	
	public Matrix(String[][] m) {
		  this.m=m;
		  this.row=m.length;
		  this.column=m[0].length;
	}
	
	public static Matrix mulMatrix(Matrix a,Matrix b) {
		int myrow=a.getRow();
		int mycolumn=b.getColumn();
		String[][] result=new String[myrow][mycolumn];
		String atemp="";
		String btemp="";
		for(int i=0;i<myrow;i++)
			for(int j=0;j<mycolumn;j++) {
				result[i][j]="";
			}
		String[][] a1=a.getM();
		String[][] b1=b.getM();
		//***************************************************************************
        for(int i=0;i<myrow;i++) {
        	   for(int j=0;j<mycolumn;j++) {
        		   for(int k=0;k<myrow;k++) {
        			   if(a1[i][k].equals("0") || b1[k][j].equals("0")) {
        				   result[i][j]+="";
        			   }else if(a1[i][k].equals("1")) {
        				   if(b1[k][j].contains("-")) {
        					   result[i][j]+=b1[k][j]; 
        				   }else {
        					   result[i][j]+="+"+b1[k][j];
        				   }
        				   
        			   }else if(b1[k][j].equals("1")) {
        				   if(a1[i][k].contains("-")) {
        					   result[i][j]+=a1[i][k];
        				   }else {
        					   result[i][j]+="+"+a1[i][k];	   
        				   }
        				
        			   }else if(b1[k][j].equals("-1")) {
        				   if(a1[i][k].contains("-")) {
        					   atemp=a1[i][k].substring(1,a1[i][k].length());
        					   result[i][j]+="+"+atemp;
        				   }else {
        					   result[i][j]+="-"+a1[i][k];	   
        				   }
        				
        			   }else if(a1[i][k].equals("-1")) {
        				   if(b1[k][j].contains("-")) {
        					   btemp=b1[k][j].substring(1,b1[k][j].length());
        					   result[i][j]+="+"+btemp; 
        				   }else {
        					   result[i][j]+="-"+b1[k][j];
        				   }
        				   
        			   }else {
        				   if(b1[k][j].contains("-")) {
        					  if(a1[i][k].contains("-")) {
        						  atemp=a1[i][k].substring(1,a1[i][k].length());
        						  btemp=b1[k][j].substring(1,b1[k][j].length());
        						  result[i][j]+=atemp+"*"+btemp;
        					  }else {
        						  btemp=b1[k][j].substring(1,b1[k][j].length());
        						  result[i][j]+="-"+a1[i][k]+"*"+btemp;
        					 }
        					   
        				   }else {
        					   if(a1[i][k].contains("-")) {
         						  atemp=a1[i][k].substring(1,a1[i][k].length());
         						 
         						  result[i][j]+="-"+atemp+"*"+b1[k][j];
         					  }else {
         						
         						  result[i][j]+="+"+a1[i][k]+"*"+b1[k][j];
         					 }
        				   }
        			   }
        				   
        			 
        		   }
        		   
        	   }
        }
        
        
        //***************************************************************************
        return new Matrix(result);
	}
	
	@Override
	public String toString() {
		String temp="";
		String[][] array=this.getM();
	    for (int i=0;i<row;i++) {
	    	for(int j=0;j<column;j++) {
	    		temp+=array[i][j]+"\t";
	    	}
	    	temp+="\n";
	    }
	    return temp;
		
	}
     public String[][] getM() {
		return m;
	}

	public void setM(String[][] m) {
		this.m = m;
	}

	public int getRow() {
		return row;
	}

	public void setRow(int row) {
		this.row = row;
	}

	public int getColumn() {
		return column;
	}

	public void setColumn(int column) {
		this.column = column;
	}

	public static void main(String[] args) {
		String[][] R=new String[3][3];
		String[][] b=new String[3][3];
		
		R[0][0]="cos(t)";
		R[0][1]="sin(t)";
		R[0][2]="0";
		R[1][0]="-sin(t)";
		R[1][1]="cos(t)";
		R[1][2]="0";
		R[2][0]="0";
		R[2][1]="0";
		R[2][2]="-1";
		Matrix a=new Matrix(R);
		
		System.out.print(a);
	}
}
