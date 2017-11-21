#include<iostream.h>
#include<math.h>
#include <string>
double temp[4][5];
double temp1[5][6];
using  std::string;

double compEntropy(double a[][5])           //熵
{
  double sum = 0;
  int n = sizeof(a) / sizeof(double);
  for(int i = 0;i < 4;i++)
    for(int j = 0;j < 5;j++)
    sum+=-a[i][j]*(log(a[i][j])/log(2));
  return sum;
}

void output(double a[][5],int nRow,int nCol)     //矩阵输出
{
  for(int i = 0;i < nRow;i++)
  {
    for(int j = 0;j < nCol;j++)
      cout<<a[i][j]<<"\t";
    cout<<endl;
  }
}


double max(double q[][5],int &m,int &n)      //打印最大值和下标
{
	double maxv = 0;
	for(int i = 0;i < 4;i++)
      for(int j = 0;j < 5;j++)
	  {
	 	  if(maxv < q[i][j])
		  { 
			maxv = q[i][j];
			m = i;
			n = j;
		  }

	  }
	return maxv;
}

void move(double q[][5],int nRow,int nCol,int u[][2],int k)     //move函数
{
  int m,n;
  for(int i = 1;i < (nRow + 1);i++)
    for(int j = 1;j < (nCol + 1);j++)
	{	
		if((i-1-u[k][0]) < 0)                        
			m = (i-1-u[k][0]) + 8;
		else
			m = abs(i-1-u[k][0]);

		if((j-1-u[k][1]) < 0)
			n = (j-1-u[k][1]) + 10;
		else
			n = abs(j-1-u[k][1]);
       temp1[i][j] = 0.8*q[m % 4 ][n % 5 ]+0.2* q[i-1][j-1];  //取模
		
	}
  for(int ii = 0;ii < 4;ii++)
    for(int j = 0 ;j < 5;j++)
		temp[ii][j] = temp1[ii+1][j+1];

		
}

void sense(double q[][5],string z,string world1[][5])     //sense函数
{
  int hit;
  for(int i = 0;i < 4;i++)
    for(int j = 0;j < 5;j++)
    {
		if(z == world1[i][j])
			hit = 1;
		else 
			hit = 0;
	
	temp[i][j] = q[i][j] *(hit * 0.7 + (1-hit) * (1 - 0.7)); 

    }
}



void  main()
{
	string world[4][5] ={{"red", "green", "green", "red" , "red"},
       					 {"red", "red", "green", "red",  "red"},
       					 {"red", "red", "green", "green",  "red"},
        				 {"red", "red", "red", "red",  "red"}};
	int nRow = sizeof(world) / sizeof(world[0]);  
	int nCol = sizeof(world[0]) / sizeof(world[0][0]);
	int motions[][2] = {{0, 0}, {0, 1}, {1, 0}, {1, 0},{0, 1}};
	int eCol = sizeof(motions) / sizeof(motions[0]);
	double entropy[2][5];
	double sum1 = 0;
    string measurements[] = {"green", "green", "green" ,"green", "green"};
    double p[4][5],p0[4][5];
   	
	int r_index = 0,c_index = 0;
	double maxV;
	for(int i = 0;i < nRow;i++)
		for(int j = 0;j<nCol;j++)
		p[i][j] = (double)1/(nRow*nCol);

	for(int ii=0;ii<2;ii++)
	  for(int j=0;j<eCol;j++)
		entropy[ii][j] = 0;

	for(int k=0;k<eCol;k++)
	  {
		move(p,nRow,nCol,motions,k);     	//计算move
		for(int i=0;i<nRow;i++)
		  for(int j=0;j<nCol;j++)
			{
			  p[i][j] = temp[i][j];
			  p0[i][j] = p[i][j];
			}

	sense(p,measurements[i], world);   //计算sense
	for(int ii=0;ii<nRow;ii++)         
            for(int j=0;j<nCol;j++)
		{
		p[ii][j] = temp[ii][j];
		sum1+= p[ii][j];
		}
	
	for(int i1=0;i1<nRow;i1++)
            for(int j=0;j<nCol;j++)
				p[i1][j] = (double)p[i1][j]/sum1; 
	sum1 = 0;
       
 //   entropy[0][i]=compEntropy(p0);
 //   entropy[1][i]=compEntropy(p);


	 cout<<"step"<<k<<"The probability before sensing:"<<endl;
	 output(p0,nRow,nCol);
	 cout<<"step"<<k<<"The probability after sensing:"<<endl;
	 output(p,nRow,nCol);
	}
	maxV=max(p,r_index,c_index);
	cout<<"The largest probability "<<maxV<<" occurs at cell"<<"["<<r_index<<"]["<<c_index<<"]"<<endl;


}