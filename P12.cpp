#include<iostream>
#include<string>
const double pCan = 0.001;
const double pNon = 0.999;       
const double pPosCan = 0.8;                          
const double pPosNon = 0.1;

int main()
{	
	using namespace std;
	string z;
	double p[2];
	double sum;
	cout<<"Enter the result of test(positive or negative): ";
	cin>>z;
	if(z=="positive")
	{
		p[0]=pPosCan * pCan;
		p[1]=pPosNon * pNon;
	}
	else
	{
		p[0]=(1 - pPosCan) * pCan;
		p[1]=(1 - pPosNon) * pNon;
	}
	sum=p[0]+p[1];
	p[0]=p[0]/sum;
	p[1]=p[1]/sum;
	cout<<"The probability of having cancer given the "<<z<<" test: "<<endl;
	cout<<p[0]<<endl;
	cout<<"The probability of cancer free given the "<<z<<" test: "<<endl;
	cout<<p[1]<<endl;
	return 0;
}

