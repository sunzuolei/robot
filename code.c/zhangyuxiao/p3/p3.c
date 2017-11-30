# include <stdio.h>
int main()
{
	float prRed,prGreen,pHit,pMiss,p1,p2,sum1,sum2;			  
	float poRed,poGreen;
	float poRed1,poGreen1; 
	float p11,p21;
	prRed=0.2, prGreen=0.2,pHit=0.6,pMiss=0.2;
	p1=prRed*pHit;
	p2=prGreen*pMiss;
	sum1=p1*2.0+ p2*3.0;
	poRed=p1/sum1;
	poGreen=p2/sum1;
	printf("z='red'\n");
	printf("%f %f %f %f %f\n",poGreen,poRed,poRed,poGreen,poGreen);
	p11=prRed*pMiss;
	p21=prGreen*pHit;
	sum2=p11*2.0+ p21*3.0;
	poRed1=p11/sum2;
	poGreen1=p21/sum2;
	printf("z='green'\n");  
	printf("%f %f %f %f %f\n",poGreen1,poRed1,poRed1,poGreen1,poGreen1); 
	getchar();
	return 0;
}
