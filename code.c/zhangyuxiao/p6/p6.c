# include <stdio.h>
int main()
{
	float p[5]={1.0,0.0,0.0,0.0,0.0};
	float p1[5]={0.0,0.0,0.0,0.0,0.0};
	float p2[5]={0.0,0.0,0.0,0.0,0.0};
	float p3[5]={0.0,0.0,0.0,0.0,0.0}; 
	float pExact,pOvershoot,pUndershoot;
	pExact=0.8;
	pOvershoot=0.1;
	pUndershoot=0.1;
	printf("第一次移动的数组:\n");
	for(int i=0;i<5;i++)
	{   
		p1[1]=p[0]*pOvershoot;
		p1[2]=p[0]*pExact;
		p1[3]=p[0]*pOvershoot;
		p1[4]=p[1]*pExact;
		p1[0]=p[3]*pUndershoot;
		printf("%f  ",p1[i]);
	}
	printf("\n");
	printf("第二次移动的数组:\n");  
	for(int i=0;i<5;i++)
	{
		p2[2]=p1[1]*pOvershoot;
		p2[3]=p1[1]*pExact+ p1[2]*pOvershoot;
		p2[4]=p1[1]*pOvershoot+p1[2]*pExact+p1[3]*pOvershoot;
		p2[0]=p1[2]*pUndershoot+p1[3]*pExact;
		p2[1]=p1[3]*pOvershoot;
		printf("%f  ",p2[i]);
	}
	printf("\n");
	printf("第三次移动的数组:\n");
	for(int i=0;i<5;i++)
	{
		p3[1]=p2[0]*pOvershoot+p2[3]*pUndershoot+p2[4]*pExact;
		p3[2]=p2[0]*pExact+p2[1]*pUndershoot+p2[4]*pUndershoot;
		p3[3]=p2[0]*pOvershoot+p2[1]*pExact+p2[2]*pOvershoot;
		p3[4]=p2[1]*pOvershoot+p2[2]*pExact+p2[3]*pOvershoot;
		p3[0]=p2[2]*pUndershoot+p2[3]*pExact+p2[4]*pUndershoot;
		printf("%f  ",p3[i]); 
	}
	getchar();
	return 0;
}
