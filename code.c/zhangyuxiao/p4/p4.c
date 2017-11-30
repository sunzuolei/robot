# include <stdio.h>
int main()
{
	float p[5]={1.0/9.0,1.0/3.0,1.0/3.0,1.0/9.0,1.0/9.0};			// 左移一位即为逆序输出
	int i;
	for(i=0;i<=4;i++)
	{
		printf("%f ",p[i]);
	}

	printf("\n");
	for(i=4;i>=0;i--)
	{
		printf("%f ",p[i]);
	}
	getchar();
	return 0;
}

