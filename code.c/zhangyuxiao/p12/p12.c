# include <stdio.h>
int main()
{
	float pCan,pNon,pPosCan,pPosNon;
	float pPos;
	float pCanPos,pNonPos;
	pCan=0.001;
	pNon=0.999;
	pPosCan=0.8;
	pPosNon=0.1;
	pPos=pPosCan*pCan+pPosNon*pNon;
	pCanPos=(pPosCan*pCan)/pPos;
	pNonPos=(pPosNon*pNon)/pPos;
	printf("The probability of the pCanPos is:%f\n",pCanPos);
	printf("The probability of the pNonPos is:%f\n",pNonPos);
	getchar();
	return 0;
}
