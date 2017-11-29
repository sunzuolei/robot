import numpy as np
from matplotlib import pyplot as plt

def move(p, u, pExact, pOvershoot, pUndershoot):
    q=(np.roll(p,u)*pExact)+(np.roll(p,u+1)*pOvershoot)+(np.roll(p,u-1)*pUndershoot)
    return q
p=np.array([1, 0, 0, 0, 0])
u=1
step=100
pExact = 0.8
pOvershoot = 0.1
pUndershoot = 0.1
for i in range(step):
    p = move(p, u, pExact, pOvershoot, pUndershoot)
    print(i+1)
    print(p)
    plt.figure(i + 1)
    plt.ylabel('Probability')
    my_title = 'step = ' + str(i + 1)
    print(my_title)
    plt.title(my_title)
    plt.bar(range(len(p)), p)
    plt.grid()  # 添加网格
    plt.pause(0.2)



