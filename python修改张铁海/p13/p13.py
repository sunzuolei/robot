from compMean import compMean
from compVariance import compVariance
import numpy as np

x=[7,38,4,23,18]
# x=[17,19,18,17,19]
# x=[18,18,18,18,18]
x=np.mat(x)
mu=compMean(x)
sigma2=compVariance(x)
print('The Expectation / Mean:\t %.2f \n'%mu)
print('The Variance is:\t\t %.2f \n'%sigma2)
print('The Standard Deviation is:\t %.2f \n'%np.sqrt(sigma2))