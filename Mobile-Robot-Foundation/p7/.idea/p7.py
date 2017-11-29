import numpy as np
from matplotlib import pyplot as plt

def move(p, u, pExact, pOvershoot, pUndershoot):
    q=(np.roll(p,u)*pExact)+(np.roll(p,u+1)*pOvershoot)+(np.roll(p,u-1)*pUndershoot)
    return q

def ce(p):
    ce=-1 * np.dot(p, (np.log(p) / np.log(2)))
    return ce

#使用此函数剔除p中的0元素，剩余的非零元素返回a
def out0(p):
    a=[]
    for index,value in enumerate(p):
        if (not value == 0):
            a.append(p[index])
    return a

p=np.array([1, 0, 0, 0, 0])
u=1
step=100
pExact = 0.8
pOvershoot = 0.1
pUndershoot = 0.1
entropy=np.zeros(step+1)
for i in range(1,step+1):
    p = move(p, u, pExact, pOvershoot, pUndershoot)
    entropy[i]=ce(out0(p))
plt.title('The change of entropy in the process of moving')
plt.plot((range(step+1)),entropy)
plt.grid()  # 添加网格
plt.xlabel('Motion step')
plt.ylabel('Entropy')
plt.show()