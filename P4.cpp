#include<iostream>
int main()
{
	using namespace std;
	cout<<"Enter the number of array p: ";//��������p�ĸ���
	int n;
	cin>>n;
	cout<<"Enter the moving steps u : ";//�����ƶ��ĳ���u
	int u;
	cin>>u;
	double* p=new double[n];
	double* q=new double[n];
	for (int i=0;i<n;i++)
	{
		cout<<"p["<<i<<"] : ";
		cin>>p[i];
	}
	cout<<"before moving : "<<endl;//����ƶ�ǰ������p
	for (int j=0;j<n;j++)
		cout<<"p["<<j<<"] : "<<p[j]<<endl;
	for (int jj=0;jj<n;jj++)//����p���ƶ�����
		q[(jj+u)%n]=p[jj];
	cout<<"after moving : "<<endl;//����ƶ��������q
	for (int ii=0;ii<n;ii++)
		cout<<"q["<<ii<<"] : "<<q[ii]<<endl;
	delete []p;
	delete []q;
	return 0;
}


