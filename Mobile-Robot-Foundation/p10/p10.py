from matplotlib import pyplot as plt
import numpy as np
import math

#字符串的比较函数，两个字符串相同返回1，不同返回值为0
def cmp(str1,str2):
    if(str1==str2):
        return 1
    else:
        return 0

#二维数组的索引函数，功能：在q矩阵中找到元素w的位置，并作为返回值返回
def index_arr(q,w):
    nCol = np.size(q,1)
    q_max = np.max(q)
    v = q.flatten()
    n = v.tolist()
    a = n.index(w)
    i = int(math.modf(a/nCol)[1]) + 1
    j = a%(nCol) + 1
    return i,j

#模拟机器人在一次运动过程中对其位置判决的概率分析
def sense(p,z,world,pSenseCorrect):
    nRow = np.size(p,0)
    nCol = np.size(p,1)
    q = np.zeros((nRow,nCol))
    for i in range(nRow):
        for j in range(nCol):
            hit = cmp(z,(world[i][j]))
            q[i][j]=p[i][j]*(hit * pSenseCorrect + (1-hit) * (1 - pSenseCorrect))
    q_sum = np.sum(q)
    q = q / q_sum
    return q

world = np.array([('red', 'green', 'green', 'red', 'red'),
                  ('red', 'red', 'green', 'red', 'red'),
                  ('red', 'red', 'green', 'green', 'red'),
                  ('red', 'red', 'red', 'red', 'red')])
nCol = np.size(world,1)#列数,此处与matlab对应的代码有所不同
nRow = np.size(world,0)#行数,此处与matlab对应的代码有所不同
pSenseCorrect = 0.7
pStart = 0.7
p = np.ones((nRow,nCol))
p = (1 - pStart) / (nRow * nCol - 1) * p
p[2][1] = pStart
print('The Prior:')
print(p)
measurements = np.array(['green'])
q = sense(p,measurements[0],world,pSenseCorrect)
print('The probability after sensing:')
print(q)
q_max = np.max(q)
str1 = 'The largest probability '+str(q_max)
str2 = 'occurs at cell'+str(index_arr(q,q_max))
print(str1,str2)





























