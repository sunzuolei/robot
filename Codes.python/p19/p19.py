# -*- coding: utf-8 -*-

import numpy as np
import matplotlib.pyplot as plt
import scipy.linalg as sci
import os



def gaussian1d(mu, sigma, x):
    p = 1 / (sigma * np.sqrt(2 * np.pi)) * np.exp(-(x - mu) ** 2 / (2 * sigma ** 2))
    return p

def convolute1d(fx, fy, x):
    fxy = np.convolve(fx, fy, 'same')
    fxy = fxy / np.trapz(fxy, x)
    return fxy

def product1d(fx, fy, x):
    fxLen = len(fx)
    fyLen = len(fy)
    xLen = len(x)
    if fxLen != fyLen:
        print("Probability vectors must be of the same length")
    if xLen != fxLen:
        print("X rang and probability vectors must be of the same length")
    fxy = fx * fy
    fxy = fxy / np.trapz(fxy, x)
    return fxy

x = np.arange(-10, 10.01, 0.01)
prior = gaussian1d(2, 1, x)
motionModel = gaussian1d(1, 2, x)
sensorModel = gaussian1d(5, 1, x)

probtAfterMove = convolute1d(motionModel, prior, x)
probtAfterSense = product1d(sensorModel, probtAfterMove, x)


plt.subplot(2, 1, 1)
plt.plot(x, prior, 'b-', linewidth = 2, label = 'prior')
plt.plot(x, motionModel, 'g-', linewidth = 2, label = 'motionModel')
plt.plot(x, probtAfterSense, 'r-', linewidth = 2, label = 'probtAfterSense')
plt.legend(loc = 'upper right')
plt.grid(True)
plt.title('Bayes filtering (Prediction)')
plt.ylabel('Probability')
plt.ylim(0, 0.5)

plt.subplot(2, 1, 2)
plt.plot(x, probtAfterMove, 'r-', linewidth = 2, label = 'probtAfterMove')
plt.plot(x, sensorModel, 'c-', linewidth = 2, label = 'sensorModel')
plt.plot(x, probtAfterSense, 'k-', linewidth = 2, label = 'probtAfterSense')
plt.legend(loc = 'upper left')
plt.grid(True)
plt.title('Update')
plt.ylabel('Probability')
plt.ylim(0, 0.5)

dirpath = os.path.dirname(__file__)
plt.savefig(dirpath + '\\bayesfiltering.png')

plt.show()