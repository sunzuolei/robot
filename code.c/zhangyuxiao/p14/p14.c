# include <stdio.h>
int main()
{
	float a=2.0,b=4.0,sum1=0.0,sum2=0.0;
	int n=5;
	float Expectation1,Expectation2;
	float Expectation3;
	float MenAge1[5]={7.0,38.0,4.0,23.0,18.0};
	float MenAge2[5]={0.0,0.0,0.0,0.0,0.0};
	for(int i=0;i<5;i++)
	{
		  MenAge2[i]=a*MenAge1[i]+b;
		  printf("%f  ",MenAge2[i]);
	}
    printf("\n");
	for(int i=0;i<5;i++)
	{
		sum1=sum1+MenAge1[i];
	}
	Expectation1=sum1/n;
	printf("MenAge1的均值为：%f\n",Expectation1);
	for(int i=0;i<5;i++)
	{
		sum2=sum2+MenAge2[i];
	}
	Expectation2=sum2/n;
	printf("MenAge2的均值为：%f\n",Expectation2);
	Expectation3=a*Expectation1+b;
	printf("MenAge3的均值为：%f\n",Expectation2);
	if(Expectation2=Expectation3)
		printf("E[aX+b]=aE[X]+b\n");
	else
		printf("E[aX+b]不等于aE[X]+b\n");
	getchar();
	return 0;
}

