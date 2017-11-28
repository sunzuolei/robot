// P12.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include "iostream"
#include "string"
using namespace std;

void main()
{
	float pCan = 0.001;
	float pNon = 0.999;
	float pPosCan = 0.8;
	float pPosNon = 0.1;
	float px,py;
	string z;
	cin>>z;
	if(z=="positive")
	{
		px = pPosCan*pCan;
		py = pPosNon*pNon;
	}
	else if(z=="negative")
	{
		px = (1-pPosCan)*pCan;
		py = (1-pPosNon)*pNon;
	}
	px=px/(px+py);
	py=py/(px+py);
	cout<<"p(1)="<<px<<endl;
	cout<<"p(2)="<<py<<endl;
}

