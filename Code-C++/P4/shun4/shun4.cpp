// shun4.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include <iostream>
#include <string>　
#include <vector>
using namespace std;


int main()
{
	int N, x;
	cout<<"输入数组长度与右移次数：";
    cin>>N>>x;  
    vector<double> a(N); 
	cout<<"输入元素";
    for (int i=0;i<N;i++)cin>>a[i];
    int n= x%N;  
    if (n==0);  
    else {  
        while (n--) {  
            int temp = a[N-1];  
            for (int i=N-1;i>0;i--)
				{
					a[i]= a[i-1];
				}
            a[0] = temp;  
        }  
    }  
    for (int i=0;i<a.size();i++) 
	{  
        cout<<a[i]<<' ';  
    }  
  
	return 0;
}

