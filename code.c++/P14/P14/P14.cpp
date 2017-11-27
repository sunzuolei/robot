// P14.cpp : 定义控制台应用程序的入口点。
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

int main()
{
	int a = 2;
    int b = 4;
	int x[5]={7,38,4,23,18};
	int y[5];
	for(int i=0;i<5;i++)
	{
		y[i] = a*x[i]+b;
	}
	double xmu = compMean(x,5);
    double ymu = compMean(y,5);
	cout<<"a*Xmu+b="<<a*xmu+b<<endl;
	cout<<"Ymu="<<ymu<<endl;
	return 0;
}