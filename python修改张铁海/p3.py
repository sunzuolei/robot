import numpy as np
import matplotlib.pyplot as plt

def sence(p,z,world,pHit,pMiss):
    q=np.zeros(len(p))
    for i in range(0,len(p)):
        if z==world[i]:
            hit=1
        else:
            hit=0
        q[i]=p[i]* (hit * pHit+ (1-hit) * pMiss)
    S=sum(q)
    for i in range(len(q)):
        q[i]=q[i]/S
    return q

def p3plot():
    plt.ion()
    plt.figure('Plot all')
    plt.subplot(3, 1, 1)
    plt.cla()
    plt.bar(x=(1, 2, 3, 4, 5), height=p)
    plt.ylabel('Prior')
    plt.ylim(0, 0.5)
    plt.title('Measurement=%s' % measurements[i])

    plt.subplot(3, 1, 2)
    obs = np.zeros(len(world))
    for j in range(0, len(world)):
        if measurements[i] == world[j]:
            hit = 1
        else:
            hit = 0
        obs[j] = hit * pHit + (1 - hit) * pMiss
    plt.cla()
    plt.bar(x=(1, 2, 3, 4, 5), height=obs)
    plt.ylabel('Observation')
    plt.ylim(0, 0.9)

    plt.subplot(3, 1, 3)
    plt.cla()
    plt.bar(x=(1, 2, 3, 4, 5), height=q)
    plt.xlabel('Posterior')
    plt.ylabel('Posterior')
    plt.ylim(0, 0.5)
    # plt.pause(0.5)
    plt.ioff()
    plt.show()

world=['green', 'red', 'red', 'green', 'green']
p=[0.2,0.2,0.2,0.2,0.2]
measurements=['red','red','green']
pHit=0.6
pMiss=0.2
plt.ion()
for i in range(0,len(measurements)):
    q=sence(p,measurements[i],world,pHit,pMiss)
    p3plot()
    # plt.pause(0.5)
    p=q
print(p)
p3plot()
# plt.pause(0.5)
# plt.ioff()
# plt.show()