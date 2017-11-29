import numpy as np
from matplotlib import pyplot as plt

def sense(p, z, world, pHit, pMiss):
    q = np.zeros(np.size(p))
    for i in range(len(p)):
        hit = cmp(z, world[i])
        q[i] = (p[i] * (hit * pHit + (1 - hit) * pMiss))
    q = q / np.sum(q)
    return q

def p2plot():
    plt.figure('The Prior distribution')
    plt.xlabel('Position')
    plt.ylabel('Probability of being at the positon')
    plt.grid()
    plt.bar(range(len(p)), p, color='green')

    plt.figure('Observation model')
    plt.xlabel('Position')
    plt.ylabel('Likelihood')
    obs = np.zeros(np.size(world))
    for i in range(len(world)):
        hit = cmp(z, world[i])
        obs[i] = hit * pHit + (1 - hit) * pMiss
    plt.grid()
    plt.bar(range(len(obs)), obs, color='blue')

    plt.figure('The Posterior distribution')
    plt.xlabel('Position')
    plt.ylabel('Probability of being at the positon')
    plt.grid()
    plt.bar(range(len(q)), q, color='red')

    plt.figure('Plot all')
    plt.subplot(311)
    plt.ylabel('Probability')
    plt.grid()
    plt.bar(range(len(p)), p)
    plt.subplot(312)
    plt.ylabel('Likelihood')
    plt.grid()
    plt.bar(range(len(obs)), obs)
    plt.subplot(313)
    plt.ylabel('Probability')
    plt.xlabel('Position')
    plt.grid()
    plt.bar(range(len(q)), q)
    plt.show()

def cmp(str1,str2):
    if(str1==str2):
        return 1
    else:
        return 0

world = np.array(['green', 'red', 'red', 'green', 'green'])
p = np.array([0.2, 0.2, 0.2, 0.2, 0.2]) # Prior
z = 'red'                       # Observation
pHit = 0.6                      # Observation model
pMiss = 0.2
q = sense(p,z,world,pHit,pMiss)
print(q)
p2plot()
