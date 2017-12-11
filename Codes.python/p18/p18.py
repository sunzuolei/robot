# -*- coding: utf-8 -*-
import numpy as np
import matplotlib.pyplot as plt
import scipy.linalg as sci
import os
from mpl_toolkits.mplot3d import Axes3D
import time

#warning: 此程序在进行矩阵运算的时候会花费接近十分钟的时间

def guassian2d(mu, Sigma, x, y):
    xLen = len(x)
    yLen = len(y)
    
    if xLen != yLen:
        print("The size of x and y should be the same!")
    if len(mu) != 2:
        print("The size of mu should be (2 * 1)!")
    if Sigma[0].all() != Sigma[1].all():
        print("'The covariance matrix should be symmetric!")
    if Sigma[0].any() != 2:
        print("The size of covariance matrix is invalid!")
    #numpy中用np.finfo(float).eps表示matlab中的eps
    if sci.det(Sigma) < np.finfo(float).eps:
        print("Covariance must be positive semidefinite!")
    pMat = np.zeros((xLen, yLen))

    xMat, yMat = np.meshgrid(x, y)
    #xMat = xMat.T
    #yMat = yMat.T
    i = 0
    j = 0
    for i in range(0, xLen):
        for j in range(0, yLen):
            xMinMu =  np.array([[[xMat[i, j] - mu[0]], [yMat[i, j] - mu[1]]]])
            xMinMu = np.reshape(xMinMu, (1, 2))
            p = np.exp(-0.5 * np.dot(np.dot(xMinMu, sci.inv(Sigma)), xMinMu.T))
            p = p * sci.det(2 * np.pi * Sigma) ** (-0.5)
            pMat[i, j] = p
    return pMat, xMat, yMat 



def draw3D():
    fig = plt.figure() 
    ax = fig.add_subplot(111, projection='3d')
    p = ax.plot_surface(xMat, yMat, pMat)
    ax.set_xlabel('x')
    ax.set_ylabel('y')
    ax.set_zlabel('Probability')
    ax.set_xlim(min(x), max(x))
    ax.set_ylim(min(y), max(y))
    plt.savefig(dirpath + '\gaussian2d.png')

def convert3Dview():
    viewfig = plt.figure()
    axv = viewfig.add_subplot(222, projection='3d')
    axv.plot_surface(xMat, yMat, pMat)
    axv.view_init(0, 90)
    axv.set_xlim(min(x), max(x))
    axv.set_ylim(min(y), max(y))
    plt.savefig(dirpath + '\gaussian2dxy.png')

def drawcontour():
    plt.figure()
    plt.plot(mu[0], mu[1], 'xg', linewidth = 1)
    CS = plt.contour(xMat, yMat, pMat)
    plt.clabel(CS, inline = 1, fontsize = 10)
    plt.xlabel('x')
    plt.ylabel('y')
    plt.xlim(min(x), max(x))
    plt.ylim(min(y), max(y))
    plt.savefig(dirpath + '\gaussian2dcontour.png')

mu = [6, 5]
sigmax = 2
sigmay = 1
rho = -0.2
sigmaxy = sigmax * sigmay * rho
Sigma = np.array([[sigmax ** 2, sigmaxy], [sigmaxy, sigmay ** 2]])
x = np.arange(0, 12.01, 0.01)
y = x
pMat, xMat, yMat = guassian2d(mu, Sigma, x, y)
dirpath = os.path.dirname(__file__)


def main():
    starttime = time.time()
    lasttime = time.time()
    print('The guassian2d function with numpy to compute the {} size of matrix spend {}'.format(len(pMat) * len(pMat), lasttime - starttime))
    print('The integration of p with respect to x and y is {:.4f}'.format(np.trapz(y, np.trapz(pMat, x))))
    draw3D()
    convert3Dview()
    drawcontour()
    plt.show()
    

if __name__ == '__main__':
    main()