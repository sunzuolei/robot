#-*- coding: utf-8 -*-

import matplotlib.pyplot as plt
import numpy as np


def gaussian1d(mu, sigma, x):
	p = 1/(sigma*np.sqrt(2*np.pi))*np.exp((-np.square(x-mu))/(2*(sigma**2)))
	return p
	
x = np.arange(-2,12.01,0.01)
mu = 5
sigma = 0.5
p = gaussian1d(mu, sigma, x)
if __name__ == "__main__":
	print('The integration of p with respect to x is %.f\n' %np.trapz(p,x,axis=0))
	plt.figure('One D Gaussian distribution')
	plt.plot(x,p,'b-',linewidth=4) 
	plt.plot([mu,mu],[np.min(p),np.max(p)],'r-',linewidth=4)
 
	plt.title(r'$mu=%s,sigma=%s$'%(mu,sigma))
	plt.xlabel('x')
	plt.ylabel('P(x)') 
	plt.grid('on') 
	plt.show()

