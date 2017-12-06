#-*- coding: utf-8 -*-

import matplotlib.pyplot as plt
import numpy as np
from mpl_toolkits.mplot3d import Axes3D

def gaussian2d(mu, Sigma, x, y):
	xLen = len(x)
	yLen = len(y)
	if xLen!=yLen:
		error('The size of x and y should be the same!')
	if len(mu)!=2:
		error('The size of mu should be (2 * 1)!')
	if Sigma.shape[0]!=Sigma.shape[1]:
		error('The covariance matrix should be symmetric!')
	if Sigma.shape[0]!=2:
		error('The size of covariance matrix is invalid!')
	if np.linalg.det(Sigma) < 2.2204*10**(-16):
		error('Covariance must be positive semidefinite!')
	pMat = np.zeros((xLen,yLen))
	[xMat,yMat] = np.meshgrid(x,y)
	[xMat,yMat] = [np.transpose(xMat),np.transpose(yMat)]
	for i in range(xLen):
		for j in range(yLen):
			xMinusMu = np.array([[xMat[i][j] - mu[0]],[ yMat[i][j] - mu[1]]])
			p = np.exp(-0.5*np.dot(np.dot(np.transpose(xMinusMu),np.linalg.inv(Sigma)),xMinusMu))
			p = p*np.linalg.det(2*np.pi*Sigma)**(-0.5)
			pMat[i][j] = p
	return pMat, xMat, yMat
			
mu = np.array([6,5])
sigmax = 2
sigmay = 1
rho = -0.2
sigmaxy = sigmax * sigmay * rho
Sigma = np.array([[sigmax**2,sigmaxy],[sigmaxy,sigmay**2]])
x = np.arange(0,12.01,0.01)
y = x
[pMat, xMat, yMat] = gaussian2d(mu, Sigma, x, y)
if __name__ == "__main__":
	print('The integration of p with respect to x and y is %.4f\n'%np.trapz(np.trapz(pMat,x),y))

	fig = plt.figure('2D Gaussian distribution1')
	ax = Axes3D(fig)
	ax.view_init(30,35)
	ax.plot_surface(xMat, yMat, pMat, rstride=1, cstride=1, cmap='rainbow')
	ax.set_xlabel("x")
	ax.set_ylabel("y")
	ax.set_zlabel("Probability")
	plt.axis([max(x),min(x),max(y),min(y)])

	fig = plt.figure('2D Gaussian distribution2')
	ax = Axes3D(fig)
	ax.view_init(100,-270)
	ax.plot_surface(xMat, yMat, pMat, rstride=1, cstride=1, cmap='rainbow')
	plt.xlabel('x')
	plt.ylabel('y')
	plt.axis([max(x),min(x),max(y),min(y)])

	plt.figure('The contour of 2D Gaussian distribution')
	plt.plot (mu[0], mu[1], 'xg', markersize= 6, linewidth= 1)
	C = plt.contour(xMat, yMat, pMat, 8)
	plt.clabel(C, inline = True, fontsize = 10)
	plt.xlabel('x')
	plt.ylabel('y')
	plt.axis([min(x),max(x),min(y),max(y)])
	plt.show()
