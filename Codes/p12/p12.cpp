#include<iostream.h>
int main()
{
  double p[2],p1[2];
  double pCan = 0.001;
  double pNon = 0.999;       
  char *z = "positive";   
  //z = 'negative'; 
  double pPosCan = 0.8;                          
  double pPosNon = 0.1;
 if("positive"==z)
  {  
    p[0] = pPosCan * pCan;
    p[1] = pPosNon * pNon;
  }
 else
  {
    p[0] = (1-pPosCan) * pCan;
    p[1] = (1-pPosNon) * pNon;
  }
    p1[0] = p[0] / (p[0]+p[1]);
    p1[1] = p[1] / (p[0]+p[1]);
    cout<<"The probability of having cancer given the positive test:\n"<<p1[0]<<endl<<"The probability of cancer free given positive the test:\n"<<p1[1]<<endl;


}
