// P14.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include <iostream>
#include<math.h>
#include <string>
#include<cmath>
using namespace std;
double compMean(double *a,double n)
{
	double sum=0;
	for(int i=0;i<n;i++)
	{
		sum+=a[i];
	}
	double u=sum/n;
	return u;
}
double compVariance(double *a,double n,double u)
{
	double z=0;
	for(int i=0;i<n;i++)
	{
		z+=pow(a[i]-u,2);
	}
	double Var=z/n;
	return Var;
}

int main()
{
	double a=2;
	double b=4;
	double x[]={7,38,4,23,18};
	double y[5];
	for(int i=0;i<5;i++)
	{
		y[i]=a*x[i]+b;
	}
	double n=sizeof(x)/sizeof(double);
	double xmu=compMean(x,n);
	double ymu=compMean(y,n);
	cout<<"a*Xmu+b="<<a*xmu+b<<endl;
	cout<<"a*Ymu+b="<<ymu<<endl;
	return 0;
}