// shun2.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include <iostream>
 #include <string>　
using namespace std;

int main()
{
	double array[5]={/*green*/0.2,/*red*/0.2,/*red*/0.2,/*green*/0.2,/*green*/0.2};
	double pHit=0.6;
	double pMiss=0.2;
	string z;
	cout<<"输入red或者grreen：   ";
	cin>>z;
	if(z=="red")
	{
	double green=array[0]*pMiss/(array[0]*pMiss*3+array[1]*pHit*2);
	double red=array[1]*pHit/(array[0]*pMiss*3+array[1]*pHit*2);
	cout<<green<<" "<<red<<" "<<red<<" "<<green<<" "<<green;
	}
	else if(z=="green")
	{
	double green=array[0]*pHit/(array[0]*pMiss*2+array[1]*pHit*3);
	double red=array[1]*pMiss/(array[0]*pMiss*2+array[1]*pHit*3);
	cout<<green<<" "<<red<<" "<<red<<" "<<green<<" "<<green;
	}
	return 0;
}

