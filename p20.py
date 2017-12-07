#-*- coding: utf-8 -*-
import matplotlib.pyplot as plt
import numpy as np
from p17 import gaussian1d
import p19

def convolute1dParam(muPrior, sdPrior, muMotion, sdMotion):
	muAfterMove = muPrior + muMotion;
	sdAterMove  = np.sqrt(sdPrior**2 + sdMotion**2)
	return muAfterMove,sdAterMove

def product1dParam(muAfterMove, sdAfterMove, muSensor, sdSensor):
	muPost = (muAfterMove * sdSensor**2 + muSensor * sdAfterMove**2)/(sdAfterMove**2 + sdSensor**2)
	sdPost = (sdSensor**2 * sdAfterMove**2)/(sdAfterMove**2 + sdSensor**2)
	return muPost,sdPost

x = np.arange(-100,100.001,0.001)
prior         = gaussian1d(2, 1, x)    # a Gaussian Prior of mean 2 and SD 1
motionModel   = gaussian1d(1, 2, x)    # a Gaussian motion model of mean 1 and SD 2
sensorModel   = gaussian1d(5, 1, x)    # a Gaussian observation model of mean 5 and SD 1   

probAfterMove  = p19.convolute1d(motionModel, prior, x)      #prediction is convolution
probAfterSense = p19.product1d(sensorModel, probAfterMove, x) #update is multiplication
[muAfterMove, sdAfterMove]   = convolute1dParam(2, 1, 1, 2)
[muAfterSense, sdAfterSense] = product1dParam(muAfterMove, sdAfterMove, 5, 1)

probAfterMoveParam  = gaussian1d(muAfterMove, sdAfterMove, x)
probAfterSenseParam = gaussian1d(muAfterSense, sdAfterSense, x)
probAfterSenseParamSeq = p19.product1d(sensorModel, probAfterMoveParam, x)

plt.figure('Bayes filtering')
plt.subplot(211)
plt.grid('on')
plt.plot(x, probAfterMove, 'r-', linewidth= 6,label="Predicted prob")
plt.plot(x, probAfterMoveParam, 'g:', linewidth=3,label="Predicted prob \n with params")
plt.legend(loc=1,ncol=1)
plt.title('Bayes filtering (Prediction)')
plt.ylabel('Probability')
plt.axis([-5,10,0,0.2])

plt.subplot(212)
plt.grid('on')
plt.title('Update')
plt.plot(x, probAfterSense, 'k-', linewidth= 6,label="Posterior")
plt.plot(x, probAfterSenseParam, 'c-', linewidth= 2,label="Posterior with params as input and output")
plt.plot(x, probAfterSenseParamSeq, 'y-',linewidth=2,label="Posterior with params as input")
plt.legend(loc=0,ncol=1)
plt.ylabel('Probability')
plt.axis([-5,10,0,0.5])
plt.show()
