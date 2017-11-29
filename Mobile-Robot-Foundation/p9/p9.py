from matplotlib import pyplot as plt
import numpy as np
import math

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

def move(p,u,pMoveCorrect):
    nCol = np.size(p, 1)  # 列数,此处与'matlab'对应的代码有所不同
    nRow = np.size(p, 0)  # 行数,此处与'matlab'对应的代码有所不同
    q = np.zeros((nRow, nCol))
    for i in range(nRow):
        for j in range(nCol):
            q[i][j] = pMoveCorrect * p[(i-u[0]) % nRow][(j-u[1]) % nCol] + (1 - pMoveCorrect) * p[i][j]
    return q

world = np.array([('red', 'green', 'green', 'red', 'red'),
                  ('red', 'red', 'green', 'red', 'red'),
                  ('red', 'red', 'green', 'green', 'red'),
                  ('red', 'red', 'red', 'red', 'red')])
nCol = np.size(world,1)#列数,此处与matlab对应的代码有所不同
nRow = np.size(world,0)#行数,此处与matlab对应的代码有所不同
stop  = np.array([0, 0])
right = np.array([0, 1])
left  = np.array([0,-1])
down  = np.array([1, 0])
up    = np.array([-1,0])
pMoveCorrect = 0.8
pStart = 0.7
p=np.ones((nRow,nCol))
p = (1 - pStart) / (nRow * nCol - 1) * p
p[2][1]=pStart
print('The Prior:')
print(p)
motions = right
q = move(p,motions,pMoveCorrect)
print('The probability after moving:')
print(q)
q_max = np.max(q)
str1 = 'The largest probability '+str(q_max)
str2 = 'occurs at cell'+str(index_arr(q,q_max))
print(str1,str2)


