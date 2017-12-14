#include<iostream.h>

int ave(int a[],int n)
{
  int sum = 0;
  for(int i=0;i<n;i++)
	sum+=a[i];
 
  return sum / n;
}

double var(int a[],int n)  
{  
    int sum = 0;  
    int average = ave(a,n);
    for(int i = 0;i<n;i++)  
      sum+= (a[i]-average) * (a[i]-average);  
    return sum / (n*1.0);  
}

int main(void)
{
  int n;
  int x1[] = {7,38,4,23,18};
  int x2[] = {17,19,18,17,19};
  int x3[] = {18,18,18,18,18};
  n = sizeof(x1) / sizeof(int);
  cout<<ave(x1,n)<<endl<<var(x1,n)<<endl<<ave(x2,n)<<endl<<var(x2,n)<<endl<<ave(x3,n)<<endl<<var(x3,n)<<endl;
  return 0;
}
