import numpy as np
p=[0, 0.5, 0, 0.5, 0]
u=2  #表示小车前进的格数
pExact=0.8
pOvershoot=0.1
pUndershoot=0.1
def move(p,u,pExact,pOvershoot,pUndershoot):
    n=len(p)
    q=np.zeros(n)
    for i in range(1,n+1):
        l=i-1
        x,y=divmod(i-1-u,n)
        # print(y)
        q[l]=pExact*p[y]
        # q.append(pExact*p[y])  #在正确的情况下，所在格子的概率
        # print(q)
        x,y=divmod(i-2-u,n)
        q[l]=q[l]+pOvershoot*p[y]
        # q.index(q[l]+pOvershoot*p[y])  #加上超过格子的误差
        x, y = divmod(i - u, n)
        q[l] = q[l] + pUndershoot * p[y]
        # q.index(q[l]+pUndershoot*p[y])#加上不足格子的误差
    print(p)
    print(q)
     # q.append(q)
move(p,u,pExact,pOvershoot,pUndershoot)