// P2.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include "iostream"
#include "string"
using namespace std;

double sum1(string world[],int n,double wd[])
{
	double sum = 0;
	double red = 0.6;
	double green = 0.2;
	for(int i=0;i<n;i++)
	{
		if(world[i] == "red")
		{
			wd[i] = red*1/n;
		}
		else if(world[i] == "green")
		{
			wd[i]=green*1/n;
		}
		sum += wd[i];
	}
	return sum;
}

double sum2(string world[],int n,double wd[])
{
	double sum = 0;
	double red = 0.2;
	double green = 0.6;
	for(int i=0;i<n;i++)
	{
		if(world[i] == "red")
		{
			wd[i] = red*1/n;
		}
		else if(world[i] == "green")
		{
			wd[i]=green*1/n;
		}
		sum += wd[i];
	}
	return sum;
}

void main()
 {
	string name;
	cin>>name;
	string world[5]={"green","red","red","green","green"};
	double wd[5];
	double p1[5];
	double p2[5];
    if(name=="red")
	{
		for(int i=0;i<5;i++)
	   {
		 p1[i] = wd[i]/sum1(world,5,wd);
		 cout<<p1[i]<<" ";
	   }
	}
	else if(name=="green")
	{
		for(int i=0;i<5;i++)
	   {
		 p2[i] = wd[i]/sum2(world,5,wd);
		 cout<<p2[i]<<" ";
	   }
	}
 }