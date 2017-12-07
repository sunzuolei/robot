#-*- coding: utf-8 -*-
import numpy as np

x = np.array([7,38,4,23,18])

def compMean(x):
	mu = np.sum(np.sum(x))/x.shape[0]
	return mu

def compVariance(x):
	x1 = np.square(x-mu)
	sigma2 = compMean(x1)
	return sigma2

mu=compMean(x)
sigma2 = compVariance(x)

if __name__=="__main__":
	print('The Expectation / Mean:\t %.1f \n'%mu)
	print('The Variance is:\t %.1f \n'%sigma2)
	print('The Standard Deviation is: %.1f \n'%np.sqrt(sigma2))
