#-*- coding: utf-8 -*-
import numpy as np
from p13 import compMean

a = 2
b = 4
x = np.array([7,38,4,23,18])
y = a*x + b

if __name__ == "__main__":
	xmu = compMean(x)
	ymu = compMean(y)

print('a * Xmu + b \t= %.2f \n'%(a * xmu + b))
print('Ymu \t\t= %.2f \n'%ymu)
