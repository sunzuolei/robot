# include <stdio.h>
int main()
{
	float Expectation1,Expectation2,Expectation3,Cov1,Cov2;
	float sum1=0.0,sum2=0.0,sum3=0.0;
	int n=5;
	float MenAge1[5]={7.0,38.0,4.0,23.0,18.0};
	float MenAge2[5]={0.0,0.0,0.0,0.0,0.0};
	float MenAge3[5]={0.0,0.0,0.0,0.0,0.0}; 
	for(int i=0;i<5;i++)
	{
		sum1=sum1+MenAge1[i];
	}
	printf("sum1 is:%f\n",sum1);
	Expectation1=sum1/n;
	printf("Expectation1 is:%f\n",Expectation1); 
	
	/*******��һ�ַ�����Cov********/
	for(int i=0;i<5;i++)
	{
		MenAge2[i]=MenAge1[i]*MenAge1[i];
		sum2=sum2+MenAge2[i];
		printf("%f  ",MenAge2[i]);
	}
	printf("\n");
	printf("sum2 is:%f\n",sum2);
	Expectation2=sum2/n;
	printf("Expectation2 is:%f\n",Expectation2);
	Cov1=Expectation2-Expectation1*Expectation1;
	printf("Cov1 is:%f\n",Cov1);
	printf("\n");
	printf("\n");
	
	/*********�ڶ��ַ�����Cov***********/
	for(int i=0;i<5;i++)
	{
		MenAge3[i]=(MenAge1[i]-Expectation1)*(MenAge1[i]-Expectation1);
		sum3=sum3+MenAge3[i];
		printf("%f  ",MenAge3[i]);
	}
	printf("\n");
	printf("sum3 is:%f\n",sum3);
	Expectation3=sum3/n;
	printf("Expectation3 is:%f\n",Expectation3);
	Cov2=Expectation3;
	printf("Cov2 is:%f\n",Cov2); 
	printf("\n");
	printf("\n");
	
	/********�ж����ַ����õ��Ľ���Ƿ���ͬ*********/
	if(Cov1=Cov2)
		printf("���ַ����õ���Cov������\n");
	else 
		printf("���ַ����õ���Cov��������!��֤����!\n");
	getchar();
	return 0;

}
