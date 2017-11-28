// P15.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include "iostream"
#include <cmath>
using namespace std;

double compMean(int x[],int n)
{
	double sum = 0;
	for(int i=0;i<n;i++)
	{
		sum += x[i];
	}
	double mu = sum/n;
	return mu;
}

double compVariance(int x[],int n,double mu)
{
	double sum = 0;
	for(int i=0;i<n;i++)
	{
		sum += pow((x[i]-mu),2);
	}
	double sigma2 = sum/n;
	return sigma2;
}

int main()
{
	int x[5]={7,38,4,23,18};
	int x2[5];
	double xmu = compMean(x,5);
	for(int i=0;i<5;i++)
	{
		x2[i] = pow(x[i],2);
	}
	double x2mu = compMean(x2,5);
	double xvar = compVariance(x,5,xmu); 
	cout<<"The Variance of X is:"<<xvar<<endl;
	cout<<"E[X^2]-E[X]^2="<<x2mu-pow(xmu,2)<<endl;
	return 0;
}