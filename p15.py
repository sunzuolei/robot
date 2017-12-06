#-*- coding: utf-8 -*-
import numpy as np
import p13

x = np.array([7,38,4,23,18])
x2 = np.square(x)
x2mu = p13.compMean(x2)
xmu = p13.compMean(x)
xvar = p13.compVariance(x)

print('The Variance of X\t= %.2f \n'%xvar)
print('E[X^2]-E[X]^2 \t\t= %.2f \n'%(x2mu - np.square(xmu)))
