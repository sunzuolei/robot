import numpy as np
import matplotlib.pyplot as plt
import numpy.linalg
from scipy.linalg import sqrtm

#
def getSigmaEllipse(x,c,nsig,n):
    # if nargin==4:  #nargin 在matlab中表示函数输入参数的个数
    inc=2 * np.pi/n
    # else:
    #     inc=np.pi/30
    #     return inc
    r=sqrtm(c)
    phi=np.arange(0,(2*np.pi),inc)  #生成起始为0，终止为(2*np.pi)，步长为inc的矩阵，不包括终值
    b=[2*np.pi,0]
    phi = np.hstack((phi, b))  #按行合并
    phi=np.mat(phi)
    z = np.vstack((np.cos(phi), np.sin(phi)))
    z=np.mat(z)
    a=nsig * r * z
    e=np.zeros_like(a)
    e[0,:]=a[0,:] +x[0]
    e[1,:]=a[1,:] +x[1]
    return e

mu=[0,0]
sigmax=5
sigmay=7
rho=0.2
sigmaxy=sigmax * sigmay * rho
Sigma=[[np.square(sigmax),sigmaxy],[sigmaxy,np.square(sigmay)]]
# print(Sigma)
# Sigma=np.mat(Sigma)
ellipsis=getSigmaEllipse(mu,Sigma,1,100)

plt.figure('The 1-sigma ellipse')
# plt.hold()
plt.plot(ellipsis[0,:],ellipsis[1,:],'ro',linewidth=3,markersize=15)
# plt.show()
plt.plot(mu[0], mu[1], 'gx',linewidth=10,markersize=10)
plt.xlabel('x')
plt.ylabel('y')
plt.grid(which='both')
plt.minorticks_on()
plt.title('σx = %.1f, σy = %.1f, ρ = %.1f'%(sigmax, sigmay, rho))
plt.xlim(-5.5,5.5,0.5)
plt.ylim(-5.5,5.5)
plt.show()