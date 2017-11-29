import numpy as np
from matplotlib import pyplot as plt

def sense(p, z, world, pHit, pMiss):
    q = np.zeros(np.size(p))
    for i in range(len(p)):
        hit = cmp(z, world[i])
        q[i] = (p[i] * (hit * pHit + (1 - hit) * pMiss))
    q_sum = np.sum(q)
    q = q / q_sum
    return q

def p3plot():
    plt.figure('Plot all')
    plt.subplot(311)
    plt.grid()
    plt.ylabel('Prior')
    my_title='Measurement:'+measurements[k]
    plt.title(my_title)
    plt.bar(range(len(p)), p)
    plt.subplot(312)
    plt.grid()
    plt.ylabel('Observation')
    obs = np.zeros(np.size(world))
    for j in range(len(world)):
        hit= cmp(measurements[k], world[j])
        obs[j] = hit * pHit + (1 - hit) * pMiss
    plt.bar(range(len(obs)), obs)
    plt.subplot(313)
    plt.grid()
    plt.ylabel('Posterior')
    plt.xlabel('Position')
    plt.bar(range(len(q)), q)
    plt.show()

def cmp(str1,str2):
    if(str1==str2):
        return 1
    else:
        return 0

world = np.array(['green', 'red', 'red', 'green', 'green'])
p = np.array([0.2, 0.2, 0.2, 0.2, 0.2])       # Prior
measurements=np.array(['red', 'red','green']) # Observation
pHit = 0.6                                    # Observation model
pMiss = 0.2
for k in range(len(measurements)):
    q = sense(p, measurements[k], world, pHit, pMiss)
    p3plot()
    p=q
print(p)
p3plot()
plt.show()
