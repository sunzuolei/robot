#-*- coding: utf-8 -*-
import matplotlib.pyplot as plt
import numpy as np
from p17 import gaussian1d


def product1d(fx,fy,x):
	fxLen = len(fx)
	fyLen = len(fy)
	xLen = len(x)
	if fxLen!=fyLen:
		error('Probability vectors must be of the same length')
	if xLen!= fxLen:
		error('X range and probability vectors must be of the same length')
	fxy = np.multiply(fx, fy)
	fxy = fxy/np.trapz(fxy,x)
	return fxy

def convolute1d(fx,fy,x):
	fxy = np.convolve(fx,fy,mode='same')
	fxy = fxy / np.trapz(fxy,x)
	return fxy
	
x = np.arange(-10,10.01,0.01)
if __name__ == "__main__":
	prior         = gaussian1d(2, 1, x) #a Gaussian Prior of mean 2 and SD 1
	motionModel   = gaussian1d(1, 2, x) #a Gaussian motion model of mean 1 and SD 2
	sensorModel   = gaussian1d(5, 1, x) # a Gaussian observation model of mean 5 and SD 1
	probAfterMove  = convolute1d(motionModel, prior, x) #prediction is convolution
	probAfterSense = product1d(sensorModel, probAfterMove, x) #update is multiplication
	
	plt.figure('Bayes filtering')
	plt.subplot(211)
	plt.plot(x, prior, 'b-', linewidth = 2,label="Prior")
	plt.plot(x, motionModel, 'g-', linewidth = 2,label="Motion model")
	plt.plot(x, probAfterMove, 'r-', linewidth= 2,label="Predicted prob")
	plt.legend(loc=1,ncol=1)
	plt.title('Bayes filtering (Prediction)')
	plt.ylabel('Probability')
	plt.axis([-10,10,0,0.5])
	plt.grid('on')
	plt.subplot(212)
	plt.title('Update')
	plt.plot(x, probAfterMove, 'r-', linewidth= 2,label="Predicted prob")
	plt.plot(x, sensorModel, 'c-', linewidth= 2,label="Sensor model")
	plt.plot(x, probAfterSense, 'k-', linewidth=2,label="Posterior")
	plt.legend(loc=1,ncol=1)
	plt.ylabel('Probability')
	plt.axis([-10,10,0,0.5])
	plt.grid('on') 
	plt.show()
