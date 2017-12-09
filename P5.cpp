#include<iostream>
#include<vector>
#include<cmath>
double MOD(double,double);
const double pExact=0.8;
const double pOvershoot = 0.1;
const double pUndershoot = 0.1;

int main()
{
	using namespace std;
	cout<<"Enter the number of array p : ";
	int n;
	cin>>n;
	double* p=new double[n];
	double* q=new double[n];
	for (int i=0;i<n;i++)
	{
		cout<<"p["<<i<<"] : ";
		cin>>p[i];
	}
	cout<<"Enter the moving steps u : ";
	int u;
	cin>>u;
	cout<<"before moving : "<<endl;
	for (int j=0;j<n;j++)
		cout<<"p["<<j<<"] : "<<p[j]<<endl;
	for (int ii=0;ii<n;ii++)
	{
		q[ii]=p[int(MOD(ii-u,n))]*pExact;
		q[ii]=q[ii]+p[int(MOD(ii-(u-1),n))]*pUndershoot ;
		q[ii]=q[ii]+p[int(MOD(ii-(u+1),n))]*pOvershoot;
	}
	cout<<"after moving : "<<endl;
	for (int jj=0;jj<n;jj++)
		cout<<"q["<<jj<<"] : "<<q[jj]<<endl;
	delete []p;
	delete []q; 
	return 0;
}
double MOD(double x,double y)
{
    long n;
    double f;
    if((x<0.000000000000001 && x>-0.000000000000001) || (y<0.000000000000001 && y>-0.000000000000001))return x;
    f = x/y;
    n = (long)f;
    if(n>f) n=n-1;
    f =x-n*y;
    return f;

}



