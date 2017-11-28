// P65.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include "iostream"
#include <vector>
#include "cmath"
using namespace std;

float log2(int x)
{
	float t = log(x)/log(2);
	return t;
}

void main()
{
	int num;  
	cout<<"个数:";
    cin >> num;
    vector<int> x(num);  
    for (int i = 0; i < num; i++) 
	cin >> x[i];//输入n个数，区间[0，N）
	float h=0;
	for(int i=0;i<num;i++)
	{
	    h += x[i]*log2(x[i]);
	}
	float H = -h;
	cout<<"H="<<H<<endl;
}

