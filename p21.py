#-*- coding: utf-8 -*-
import matplotlib.pyplot as plt
import numpy as np
from p18 import gaussian2d
from mpl_toolkits.mplot3d import Axes3D
from scipy import signal
from scipy import misc

def product2d(p1, p2, x, y):
	p = np.multiply(p1, p2)
	p = p / np.trapz(np.trapz(p,x),y)
	return p
	
def makeSigma(sigmax, sigmay, rho):
	sigmaxy = sigmax * sigmay * rho
	Sigma = np.array([[sigmax**2,sigmaxy],[sigmaxy,sigmay**2]])
	return Sigma
	
def convolute2d(p1, p2, x, y):
	p= signal.convolve2d(p1,p2,boundary='symm',mode='same')
	p = p / np.trapz(np.trapz(p,x),y)
	return p

def maxMat(g):
	r=g.argmax(axis=0)
	temp=g[r,range(g.shape[1])]
	index_Row=np.argsort(temp)
	c=index_Row[len(index_Row)-1]
	r=r[c]
	return r,c
	
x = np.arange(-2,10.02,0.02)
y = x
mu1 = np.array([5,6])
mu2 = np.array([3,2])
mu3 = np.array([6,4])
#Prior
[priorMat, xMat, yMat] = gaussian2d(mu1, makeSigma(0.6, 0.9, 0.7), x, y)
#Motion model
[motMat,xMat1,yMat1] = gaussian2d(mu2, makeSigma(0.4, 0.7, 0.3), x, y)
#Observation model
[obsMat,xMat2,yMat2] = gaussian2d(mu3, makeSigma(0.6, 0.5, 0.5), x, y)
#Prediction
predMat = convolute2d(priorMat, motMat, x, y)
#Update
postMat = product2d(predMat, obsMat, x, y)

fig = plt.figure('Prediction')
ax = Axes3D(fig)
ax.view_init(30,35)
ax.plot_surface(xMat, yMat, priorMat, rstride=1, cstride=1, cmap='rainbow')
ax.text(5,6, np.max(np.max(priorMat)),'Prior',family = 'monospace', fontsize = 10)
ax.plot_surface(xMat, yMat, motMat, rstride=1, cstride=1, cmap='rainbow')
ax.text(3,2, np.max(np.max(motMat)),'Motion model',family = 'monospace', fontsize = 10)
ax.plot_surface(xMat, yMat, predMat, rstride=1, cstride=1, cmap='rainbow')
[r, c] = maxMat(predMat)
ax.text(xMat[r,c],yMat[r,c], predMat[r, c],'Predicted',family = 'monospace', fontsize = 10)
ax.set_xlabel("x")
ax.set_ylabel("y")
ax.set_zlabel("Probability")
plt.axis([max(x),min(x),max(y),min(y)])

plt.figure('Prediction contour')
plt.grid('on')
C = plt.contour(xMat, yMat, priorMat, 8)
plt.clabel(C, inline = True, fontsize = 10)
plt.text(5,6,'Prior')
C = plt.contour(xMat, yMat, motMat, 8)
plt.clabel(C, inline = True, fontsize = 10)
plt.text(3,2,'Motion model')
C = plt.contour(xMat, yMat,predMat, 8)
plt.clabel(C, inline = True, fontsize = 10)
[r, c] = maxMat(predMat)
plt.text(xMat[r,c],yMat[r,c], 'Predicted')
plt.xlabel('x')
plt.ylabel('y')
plt.axis([min(x),max(x),min(y),max(y)])

fig = plt.figure('Update')
ax = Axes3D(fig)
ax.view_init(30,35)
ax.plot_surface(xMat, yMat,predMat, rstride=1, cstride=1, cmap='rainbow')
[r, c] = maxMat(predMat)
ax.text(xMat[r,c],yMat[r,c], predMat[r, c],'Predicted',family = 'monospace', fontsize = 10)
ax.plot_surface(xMat, yMat,obsMat, rstride=1, cstride=1, cmap='rainbow')
ax.text(6,4, np.max(np.max(obsMat)),'Observation model',family = 'monospace', fontsize = 10)
ax.plot_surface(xMat, yMat,postMat, rstride=1, cstride=1, cmap='rainbow')
[r, c] = maxMat(postMat)
ax.text(xMat[r,c],yMat[r,c], postMat[r, c],'Updated',family = 'monospace', fontsize = 10)
ax.set_xlabel("x")
ax.set_ylabel("y")
ax.set_zlabel("Probability")
plt.axis([max(x),min(x),max(y),min(y)])

plt.figure('Update contour')
plt.grid('on')
C = plt.contour(xMat, yMat,predMat, 8)
plt.clabel(C, inline = True, fontsize = 10)
[r, c] = maxMat(predMat)
plt.text(xMat[r,c],yMat[r,c], 'Predicted')
C = plt.contour(xMat, yMat,obsMat, 8)
plt.clabel(C, inline = True, fontsize = 10)
ax.text(6,4, np.max(np.max(obsMat)),'Observation model',family = 'monospace', fontsize = 10)
C = plt.contour(xMat, yMat,postMat, 8)
plt.clabel(C, inline = True, fontsize = 10)
[r, c] = maxMat(postMat)
plt.text(xMat[r,c],yMat[r,c], 'Updated')
plt.xlabel('x')
plt.ylabel('y')
plt.axis([min(x),max(x),min(y),max(y)])
plt.show()
