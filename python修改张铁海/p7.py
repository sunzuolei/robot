import numpy as np
import matplotlib.pyplot as plt
p=[1, 0, 0, 0, 0]
u=1
step=100
pExact=0.8
pOvershoot=0.1
pUndershoot=0.1
entropy=np.zeros(step)
def move(p,u,pExact,pOvershoot,pUndershoot):
    n=len(p)
    q = np.zeros(n)
    for i in range(1, n + 1):
        l = i - 1
        x, y = divmod(i - 1 - u, n)
        q[l] = pExact * p[y]
        x, y = divmod(i - 2 - u, n)
        q[l] = q[l] + pOvershoot * p[y]
        x, y = divmod(i - u, n)
        q[l] = q[l] + pUndershoot * p[y]
    return q
# q=move(p,u,pExact,pOvershoot,pUndershoot)
plt.ion()
for i in range(1,step+1):
    p=move(p,u,pExact,pOvershoot,pUndershoot)
    entropy[i-1]=-sum(p * np.log2(p))
    print(i)
    print(p)
    # print(entropy)
    # print(p)
    # plt.cla()
    # x=plt.xlim(1,step)
y = entropy
plt.plot(y,'r^',linewidth=0.5,markersize=6)#,shap='-',linewidth=2,color='g'
plt.plot(y,'g',linewidth=2,markersize=2)#,shap=':',linewidth=1.5,color='r'
    # plt.xlim(1,step,10)
plt.xlabel('Motion step')
plt.ylabel('Entropy')
    # plt.pause(0.5)  #每次图表显示间隔的时间
plt.ioff()
plt.show()