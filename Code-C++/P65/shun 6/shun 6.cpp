// shun 6.cpp : �������̨Ӧ�ó������ڵ㡣
//

#include "stdafx.h"
#include <iostream>
#include<math.h>
 #include <string>��
using namespace std;
#define u 20
int i,n;
float H_X,Px[u];
float log2(float x)
{
 float z;
 z=(float)(log(x)/log(2));
 return z;
}
float entropy(float *x,int n)
{
  float z=0;
  for(i=1;i<=n;i++)
  {
   z+=(*(x+i))*log2(1/(*(x+i)));
  }
  return z;
}
int main()
{
	 cout<<"�������  ";
	 cin>>n;
	 cout<<"�������  ";
	 for(i=1;i<=n;i++)
	 {
	cin>>Px[i];
	 }
	 H_X=entropy(Px,n);
	 cout<<H_X<<endl;
	return 0;
}

