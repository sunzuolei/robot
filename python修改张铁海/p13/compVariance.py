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