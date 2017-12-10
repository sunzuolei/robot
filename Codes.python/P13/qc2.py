import numpy as np
import math
narray=np.array([7, 38, 4, 23, 18])
sum1=narray.sum()
narray2=narray*narray
sum2=narray2.sum()
mean=sum1/5
var=sum2/5-mean**2
sd=math.sqrt(var)
print("The Expectation / Mean is{:.2f}".format(mean))
print("The Variance is:{:.2f}".format(var))
print("The Standard Deviation is:{:.2f}".format(sd))

