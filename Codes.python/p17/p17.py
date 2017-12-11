# -*- coding: utf-8 -*-

import numpy as np
import matplotlib.pyplot as plt
import scipy.linalg as sci
import os



def gaussian1d(mu, sigma, x):
    p = 1 / (sigma * np.sqrt(2 * np.pi)) * np.exp(-(x - mu) ** 2 / (2 * sigma ** 2))
    return p
x = np.arange(-2, 12.01, 0.01)
mu = 5
sigma = 0.5
p = gaussian1d(mu, sigma, x)

#draw
plt.plot(x, p, 'b-', linewidth = 4)
plt.plot([mu, mu], [min(p), max(p)], 'r-', linewidth = 4)
plt.xlabel('x')
plt.ylabel('P(x)')
plt.title('mu = {:.1f}, sigma = {:.1f}'.format(mu, sigma))
dirpath = os.path.dirname(__file__)
plt.savefig(dirpath + '/guassian1d.png')
plt.show()
