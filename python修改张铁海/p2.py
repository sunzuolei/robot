import matplotlib.pyplot as plt
import numpy as np
# q=[0,0,0,0,0]
def sense(p,world,pHit,pMiss):
    q=np.zeros(len(p))
    size=int(len(p))
    obs = np.zeros(size)
    for i in range(size):
        if "red"==world[i]:
            hit=1
        else:
            hit=0
        obs[i]=hit*pHit+(1-hit)*pMiss
        q[i]=p[i]*(hit*pHit+(1-hit)*pMiss)
        # q.index(q[i])
    S=sum(q)
    for i in range(size):
        q[i]=q[i]/S
    print(q)

    plt.figure('The Prior distribution')
    plt.bar(x=(0,1,2,3,4),height=p,color='g')
    plt.ylabel("Probability of being at the positon")
    plt.xlabel("Position")
    plt.ylim(0,0.5)

    plt.figure('Observation model')
    plt.bar(x=(0, 1, 2, 3, 4), height=obs, color='b')
    plt.ylabel("Probability of being at the positon")
    plt.xlabel("Position")
    plt.ylim(0, 0.9)

    plt.figure('The Posterior distribution')
    plt.bar(x=(0, 1, 2, 3, 4), height=q, color='red')
    plt.ylabel("Probability of being at the positon")
    plt.xlabel("Position")
    plt.ylim(0, 0.5)

    plt.figure('Plot all')
    plt.subplot(311)
    plt.bar(x=(0,1,2,3,4),height=p,color='red')
    plt.ylabel('Probability')
    plt.ylim(0,0.5)
    plt.subplot(312)
    plt.bar(x=(0,1,2,3,4),height=obs)
    plt.ylabel('Likelihood')
    plt.ylim(0, 0.9)
    plt.subplot(313)
    plt.bar(x=(0,1,2,3,4),height=q)
    plt.xlabel('Position')
    plt.ylabel('Probability')
    plt.ylim(0,0.5)
    plt.show()

world=["green","red","red","green","green"]
p=[0.2,0.2,0.2,0.2,0.2]
pHit=0.6
pMiss=0.2
sense(p,world,pHit,pMiss)

