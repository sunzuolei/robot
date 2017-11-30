#include <ansi_c.h>
# include <stdio.h>
int main()
{
	float Expectation,Variance,StandardDeviation; 
	int n=5;
	float MenAge[5]={7.0,38.0,4.0,23.0,18.0};
	float sum1=0.0;
	float sum2=0.0;
    for (int i=0;i<5;i++)
	{
		sum1=sum1+MenAge[i];
	}
	printf("sum1 is: %f\n",sum1);
	Expectation=sum1/n;
	printf("Expectation is: %f\n",Expectation);
	for(int i=0;i<5;i++)
	{
		sum2=sum2+(MenAge[i]-Expectation)*(MenAge[i]-Expectation);
	}
	printf("sum2 is: %f\n",sum2);
	Variance=sum2/n;
	printf("Variance is: %f\n",Variance);
	StandardDeviation=sqrt(Variance);
	printf("StandardDeviation is: %f\n",StandardDeviation); 
	getchar();
	return 0;
}
