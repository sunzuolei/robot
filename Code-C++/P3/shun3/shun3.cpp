// shun3.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include <iostream>
 #include <string>　
using namespace std;

void function1()
{
	double pHit=0.6;
	double pMiss=0.2;
	double array[5]={/*green*/0.2,/*red*/0.2,/*red*/0.2,/*green*/0.2,/*green*/0.2};
	double temp0=array[0];
	double temp1=array[1];
	double temp00=temp0*pMiss/(temp0*pMiss*3+temp1*pHit*2);
	double temp11=temp1*pHit/(temp0*pMiss*3+temp1*pHit*2);
	array[0]=temp00*pHit/(temp00*pHit*3+temp11*pMiss*2);
	array[1]=temp11*pMiss/(temp00*pHit*3+temp11*pMiss*2);
	cout<<array[0]<<" "<<array[1]<<" "<<array[1]<<" "<<array[0]<<" "<<array[0];
}
int main()
{
	string z;
	int n;
	cout<<"输入red,green:  ";
	cin>>z;
	if(z=="red,green")
	{
		function1();
	}
	return 0;
}

