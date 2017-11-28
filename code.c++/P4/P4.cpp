// P4.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"  
#include <iostream>  
#include <vector>  
using namespace std;  
  
int main()  
{  
    int num, shift;  
	cout<<"数组长度:";
    cin >> num;
	cout<<"右移位数:";
	cin>>shift;
    vector<int> array(num);  
    for (int i = 0; i < num; i++) 
	cin >> array[i];//输入n个数，区间[0，N）  
    int pos = shift%num;  
    if (pos == 0);  
    else {  
        while (pos--) {  
            int temp = array[num - 1];  
            for (int i = num - 1; i > 0; i--) array[i] = array[i - 1];  
            array[0] = temp;  
        }  
    }  
    for (int i = 0; i < array.size(); i++) {  
        cout << array[i]<<' ';  
    }  
    return 0;  
}  