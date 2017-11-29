from matplotlib import pyplot as plt
import numpy as np

def move(p, u, pExact, pOvershoot, pUndershoot):
    q=(np.roll(p,u)*pExact)+(np.roll(p,u+1)*pOvershoot)+(np.roll(p,u-1)*pUndershoot)
    return q

def cmp(str1,str2):
    if(str1==str2):
        return 1
    else:
        return 0

def sense(p, z, world, pHit, pMiss):
    q = np.zeros(np.size(p))
    for i in range(len(p)):
        hit = cmp(z, world[i])
        q[i] = (p[i] * (hit * pHit + (1 - hit) * pMiss))
    q_sum = np.sum(q)
    q = q / q_sum
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


world = np.array(['green', 'red', 'red', 'green', 'green'])
p = np.array([0.2, 0.2, 0.2, 0.2, 0.2]) # Prior
measurements=np.array(['red', 'green']) # Observation
motions = np.array([1, 1])              # Motions
pHit = 0.6                              # Observation model
pMiss = 0.2
pExact = 0.8
pOvershoot = 0.1
pUndershoot = 0.1
entropy = np.zeros((2,len(motions)))
for i in range(len(measurements)):
    p = sense(p, measurements[i], world, pHit, pMiss)
    a=out0(p)
    entropy[0,i] = ce(a)
    p = move(p, motions[i], pExact, pOvershoot, pUndershoot)
    b=out0(p)
    entropy[1,i] = ce(b)
print('The final posterior:')
print(p)
print('The final entropy:')
print(entropy)
plt.figure(1)
plt.xlabel('Index of cell')
plt.ylabel('Posterior')








