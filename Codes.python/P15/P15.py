#-------by HYH -------#
import sys
sys.path.append('D:\\Python File\\robot\\P13')
import P13
import numpy as np
x=np.array([7,38,4,23,18])
x2=np.square(x)
x2mu=P13.compMean(x2)
xmu=P13.compMean(x)
xvar=P13.compVariance(x)
print('The Variance of X \t=%s \n'%xvar)
print('E[X^2]-E[X]^2 \t\t=%s \n'%(x2mu-np.square(xmu)))