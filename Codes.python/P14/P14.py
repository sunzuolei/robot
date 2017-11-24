#-------by HYH -------#
import sys
sys.path.append('D:\\Python File\\robot\\P13')
import P13
import numpy as np
a=2
b=4
x=np.array([7,38,4,23,18])
y=a*x+b
xmu=P13.compMean(x)
ymu=P13.compMean(y)
print('a*Xmu+b\t=%s \n'%(a*xmu+b))
print('Ymu\t\t=%s \n'%ymu)