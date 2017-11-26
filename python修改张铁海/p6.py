import numpy as np
import matplotlib.pyplot as plt
p=[1, 0, 0, 0, 0]
u=1
step=20
pExact=0.8
pOvershoot=0.1
pUndershoot=0.1
# n=len(p)
# q = np.zeros(n)
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
fig1=plt.figure(figsize=(10,10),dpi=80)
plt.ion()  #开启交互模式
# q=move(p,u,pExact,pOvershoot,pUndershoot)
for i in range(1,step+1):
    print(i)
    p=move(p,u,pExact,pOvershoot,pUndershoot)
    print(p)
    plt.cla()
    plt.bar(x=(1,2,3,4,5),height=p)
    plt.title('step=%s'%i)
    plt.ylim(0,1)
    plt.ylabel('Probability')
    plt.pause(0.5)
plt.ioff()#关闭交互模式，如果不关闭图像就会一闪而过，不会长留
plt.show()

