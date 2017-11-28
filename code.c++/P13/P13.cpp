// P13.cpp : 定义控制台应用程序的入口点。
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
	double mu = compMean(x,5);
	double sigma2 = compVariance(x,5,mu); 
	cout<<"The Expectation / Mean is:"<<mu<<endl;
	cout<<"The Variance is:"<<sigma2<<endl;
	cout<<"The Standard Deviation is:"<<sqrt(sigma2)<<endl;
	return 0;
}