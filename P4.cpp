#include<iostream>
int main()
{
	using namespace std;
	cout<<"Enter the number of array p: ";//输入数组p的个数
	int n;
	cin>>n;
	cout<<"Enter the moving steps u : ";//输入移动的长度u
	int u;
	cin>>u;
	double* p=new double[n];
	double* q=new double[n];
	for (int i=0;i<n;i++)
	{
		cout<<"p["<<i<<"] : ";
		cin>>p[i];
	}
	cout<<"before moving : "<<endl;//输出移动前的数组p
	for (int j=0;j<n;j++)
		cout<<"p["<<j<<"] : "<<p[j]<<endl;
	for (int jj=0;jj<n;jj++)//数组p的移动过程
		q[(jj+u)%n]=p[jj];
	cout<<"after moving : "<<endl;//输出移动后的数组q
	for (int ii=0;ii<n;ii++)
		cout<<"q["<<ii<<"] : "<<q[ii]<<endl;
	delete []p;
	delete []q;
	return 0;
}


