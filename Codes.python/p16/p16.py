#-*- coding: utf-8 -*-

import numpy as np
import matplotlib.pyplot as plt
import scipy.linalg as sci
import os

def getSigmaEllipse(x, c, nsig, n):
    if len(x) < 1 or len(c) < 1 or nsig == None or n == None:
        inc = np.pi / 30
    else:
        inc = np.pi * 2 / n
    r = sci.sqrtm(c)
    larr = list(np.arange(0, 2 * np.pi + inc, inc))
    larr.append(0)
    phi = np.round(larr, decimals=4)
    #17/12/8 fix bug:np.array([[np.cos(phi)],[np.sin(phi)]]).shape为(2, 1, 102), 进行dot运算时会出现dim错误
    #故应该用reshape将数组转换为维度为(2, 102)的数组再进行运算
    tmp = np.reshape(np.array([[np.cos(phi)],[np.sin(phi)]]), (2, 102))
    a = nsig * np.dot(r,tmp)
    a[0] = a[0] + x[0]
    a[1] = a[1] + x[1]
    return a
    


#作图
def drawimg(x1, y1, x2, y2):
    plt.plot(x1, y1, 'r-', linewidth = 6)
    plt.plot(x2, y2, 'xg', linewidth = 6)
    plt.xlabel('x')
    plt.ylabel('y')
    plt.title('sigma_x={:.1f}, sigma_y={:.1f}, rho={:.1f}'.format(sigmax, sigmay, rho))
    plt.xlim(-5.5, 5.5)
    plt.ylim(-5.5, 5.5)
    plt.grid(True)
    xhis = np.arange(-5, 5.5, 0.5)
    yhis = np.arange(-5, 6, 1)
    axis = plt.gca()
    axis.set_xticks(xhis)
    axis.set_yticks(yhis)
    #sava image
    dirpath = os.path.dirname(__file__)
    plt.savefig(dirpath + '/sigma.png')
    plt.show()

mu = [0, 0]
sigmax = 5
sigmay = 7
rho = 0.2

def main():
    sigmaxy = sigmax * sigmay * rho
    Sigma = np.array([[sigmax ** 2, sigmaxy], [sigmaxy, sigmay ** 2]])
    ellipse = getSigmaEllipse(mu, Sigma, 1, 100)
    drawimg(ellipse[0], ellipse[1], mu[0], mu[1])


if __name__ == '__main__':
    main()