# include <stdio.h>
int main()
{
	int i;
	float p[5]={0.0,0.5,0.0,0.5,0.0};
	float p1[5]={0.0,0.0,0.0,0.0,0.0};
	float pExact,pOvershoot,pUndershoot;
	pExact=0.8;
	pOvershoot=0.1;
	pUndershoot=0.1;
	printf("原本的输入数组p:\n");
	for(i=0;i<5;i++)
	{
		printf("%f  ",p[i]);
	}
	printf("\n");
	printf("移位后的输入数组p1:\n"); 
	for(i=0;i<5;i++)
	{   
		p1[2]=p[1]*pOvershoot;
		p1[3]=p[1]*pExact;
		p1[4]=p[1]*pOvershoot+p[3]*pUndershoot;
		p1[0]=p[3]*pExact;
		p1[1]=p[3]*pUndershoot;
		p1[2]=p[1]*pOvershoot;
		printf("%f  ",p1[i]);
	}
	getchar();    
	return 0;
}
