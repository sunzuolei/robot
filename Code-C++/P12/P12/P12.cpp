// P12.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include <iostream>
 #include <string>　
using namespace std;


int main()
{
	float pCan=0.001;
	float pNon=0.999;
	float pPosCan=0.8;
	float pPosNon=0.1;
	float p[2];
	string str;
	cin>>str;
	if(str=="positive")
	{
		float p1=pPosCan*pCan;
		float p2=pPosNon * pNon;
		float P1=p1/(p1+p2);
		float P2=p2/(p1+p2);
		cout<<"The probability of having cancer given the "<<P1<<"   ";
		cout<<P2<<endl;
	}
	else
	{
		float p1=(1-pPosCan)*pCan;
		float p2=(1-pPosNon)*pNon;
		float P1=p1/(p1+p2);
		float P2=p2/(p1+p2);
		cout<<"The probability of having cancer given the "<<P1<<"   ";
		cout<<P2<<endl;
	}
	return 0;
}

