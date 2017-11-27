// shun1.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include <iostream>　
using namespace std;
int main()
{
    double i;
	cout<<"输入n  ";
	cin>>i;
	double r;
	r=1/i;
    for(i;i>0;i--) 
	{
       cout<<r<<" ";
    }
    return 0;
}

