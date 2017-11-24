#-------by HYH -------#
import numpy as np
x=np.array([7,38,4,23,18])
xCol=np.shape(x)
def compMean(x):
	mu=np.sum(np.sum(x))/xCol
	return mu

def compVariance(x):
	x1=np.square(x-mu)
	sigma2=compMean(x1)
	return sigma2
mu=compMean(x)
sigma2=compVariance(x)
if __name__ == '__main__':
	print('The Expectation / Mean:%s \n'%mu)
	print('The Variance is:%s \n'%sigma2)
	print('The Standard Deviation is:%s \n'%np.sqrt(sigma2))