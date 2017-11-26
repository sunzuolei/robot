import numpy as np
def compMean(x):   #计算均值的
    S=np.sum(x)
    shape=x.shape[:]
    mu=S/(shape[0]*shape[1])
    return mu