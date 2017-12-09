#include<iostream>

int main()
{
	using namespace std;
	cout<<"Enter the number n: ";
	int n;
	cin>>n;
	double* p=new double[n];
	for (int i=0;i<n;i++)
		p[i]=1.0/n;
	for (int j=0;j<n;j++)
		cout<<"p["<<j<<"] : "<<p[j]<<endl;
	cout<<endl;
	delete []p;
	return 0;
}