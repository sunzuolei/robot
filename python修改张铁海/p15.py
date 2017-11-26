import numpy as np
from p13 import compMean
from p13 import compVariance

x= [7, 38, 4, 23, 18]
x=np.mat(x)
x2= np.square(x)
# print(x2)
x2mu= compMean.compMean(x2)
xmu = compMean.compMean(x)
xvar= compVariance.compVariance(x)
print('The Variance of X \t= %.2f \n'%xvar)
print('E[X^2]-E[X]^2 \t\t= %.2f \n'%(x2mu - np.square(xmu)))