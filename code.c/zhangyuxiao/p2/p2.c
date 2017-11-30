#include <ansi_c.h>
# include <stdio.h>
int main()
{   
	int hit;
	float sum=0;
	char *world[5]={"green","red","red","green","green"};
	float p[5]={0.2,0.2,0.2,0.2,0.2};
	char *z="red";
	float pHit=0.6;
	float pMiss=0.2;
	float q[5]={0,0,0,0,0};
	for(int i=0;i<5;i++)
	{
		 hit=strcmp(z,world[i]);
		 q[i]=p[i]*(hit*pHit+(1-hit)*pMiss);
		 sum=sum+q[i];
	}
	for(int i=0;i<5;i++)
	{
		q[i]=q[i]/sum;
		printf("q is %f\n",q[i]);
	}
	getchar();
	return 0;
}
