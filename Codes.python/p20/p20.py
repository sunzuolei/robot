# -*- coding: utf-8 -*-

import numpy as np
import matplotlib.pyplot as plt
import scipy.linalg as sci
import os
from p19 import gaussian1d,convolute1d, product1d


def convolute1dParam(muPrior, sdPrior, muMotion, sdMotion):
    muAfterMove = muPrior + muMotion
    sdAfterMove = np.sqrt(sdPrior ** 2 + sdMotion ** 2)
    return muAfterMove, sdAfterMove

def product1dParam(muAfterMove, sdAfterMove, muSensor, sdSensor):
    muPost = (muAfterMove * sdSensor ** 2 + muSensor * sdAfterMove ** 2) / (sdAfterMove ** 2 + sdSensor ** 2)
    sdPost = (sdSensor ** 2 * sdAfterMove ** 2) / (sdAfterMove ** 2 + sdSensor ** 2)
    return muPost, sdPost

x = np.arange(-100, 100.001, 0.001)
prior = gaussian1d(2, 1, x)
motionModel = gaussian1d(1, 2, x)
sensorModel = gaussian1d(5, 1, x)

probAfterMove = convolute1d(motionModel, prior, x)
probAfterSense = product1d(sensorModel, probAfterMove, x)

muAfterMove, sdAfterMove = convolute1dParam(2, 1, 1, 2)
muAfterSense, sdAfterSense = product1dParam(muAfterMove, sdAfterMove, 5, 1)

probAfterMoveParam = gaussian1d(muAfterMove, sdAfterMove, x)
probAfterSenseParam = gaussian1d(muAfterSense, sdAfterSense, x)

probAfterSenseParamSeq = product1d(sensorModel, probAfterMoveParam, x)

plt.subplot(2, 1, 1)
plt.grid(True)
plt.plot(x, probAfterMove, 'r-', linewidth = 6, label = 'probAfterMove')
plt.plot(x, probAfterMoveParam, 'g:', linewidth = 3, label = 'probAfterMoveParam')
plt.legend(loc = 'upper right')
plt.title('Bayes filtering (Prediction)')
plt.ylabel('Probability')
plt.ylim(0, 0.2)
plt.xlim(-5, 10)

plt.subplot(2, 1, 2)
plt.grid(True)
plt.plot(x, probAfterSense, 'k-', linewidth = 6, label = 'probAfterSense')
plt.plot(x, probAfterSenseParam, 'c-', linewidth = 3, label = 'probAfterSenseParam')
plt.plot(x, probAfterSenseParamSeq, 'y-', linewidth = 2, label = 'probAfterSenseParamSeq')
plt.legend(loc = 'upper right')
plt.title('Title')
plt.ylabel('Probability')
plt.ylim(0, 0.2)
plt.xlim(-5, 10)

dirpath = os.path.dirname(__file__)
plt.savefig(dirpath + '\\bayesfiltewithparams.png')

plt.show()
