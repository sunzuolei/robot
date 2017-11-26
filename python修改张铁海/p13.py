from compMean import compMean
from compVariance import compVariance
import numpy as np

def mean(x):  #计算均值的
    S = np.sum(x)   #矩阵中每个元素求和必须用np.sum
    shape = x.shape[:]
    mean=S/(shape[0]*shape[1])
    return mean

def compVariance(x):   #计算方差的
    mu=mean(x)
    mu=np.mat(mu)
    x2=np.square(x-mu)
    sigma2=mean(x2)
    return sigma2
def compMean(x):   #计算均值的
    S=np.sum(x)
    shape=x.shape[:]
    mu=S/(shape[0]*shape[1])
    return mu

x=[7,38,4,23,18]
# x=[17,19,18,17,19]
# x=[18,18,18,18,18]
x=np.mat(x)
mu=compMean(x)
sigma2=compVariance(x)
print('The Expectation / Mean:\t %s \n'%mu)
print('The Variance is:\t\t %s \n'%sigma2)
print('The Standard Deviation is:\t %s \n'%np.sqrt(sigma2))