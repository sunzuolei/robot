// P65.cpp : �������̨Ӧ�ó������ڵ㡣
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
	cout<<"����:";
    cin >> num;
    vector<int> x(num);  
    for (int i = 0; i < num; i++) 
	cin >> x[i];//����n����������[0��N��
	float h=0;
	for(int i=0;i<num;i++)
	{
	    h += x[i]*log2(x[i]);
	}
	float H = -h;
	cout<<"H="<<H<<endl;
}

