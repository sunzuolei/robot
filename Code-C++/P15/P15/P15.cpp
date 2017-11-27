// P15.cpp : 定义控制台应用程序的入口点。
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
	double x[]={7,38,4,23,18};
	double x2[5];
	double n=sizeof(x)/sizeof(double);
	for(int i=0;i<5;i++)
	{
		x2[i]=pow(x[i],2);
	}
	double x2mu=compMean(x2,n);
	double xmu=compMean(x,n);
	double xvar=compVariance(x,n,xmu);
	cout<<"The Variance of x="<<xvar<<endl;
	cout<<"E[x^2]-E[x]^2="<<x2mu-pow(xmu,2)<<endl;
	return 0;
}

