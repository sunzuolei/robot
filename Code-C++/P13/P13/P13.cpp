// P13.cpp : 定义控制台应用程序的入口点。
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
	double a[5]={7,38,4,23,18};
	double n=sizeof(a)/sizeof(double);
	double u=compMean(a,n);
	double sigma2=compVariance(a,n,u);
	cout<<"u="<<u<<endl;
	cout<<"sigma2="<<sigma2<<endl;
	cout<<"sqrt(sigma2)="<<sqrt(sigma2)<<endl;
	return 0;
}

