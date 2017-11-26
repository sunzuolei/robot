import numpy as np
import matplotlib.pyplot as plt
def sense(p,z,world,pHit,pMiss):
    size=int(len(p))
    # obs = np.zeros(size)
    q=np.zeros(len(p))
    for i in range(size):
        if z==world[i]:
            hit=1
        else:
            hit=0
        # obs[i]=hit*pHit+(1-hit)*pMiss
        q[i]=p[i]*(hit*pHit+(1-hit)*pMiss)
        # q.index(q[i])
    S=sum(q)
    for i in range(size):
        q[i]=q[i]/S
    # print(q)
    return q
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
p=[0.2, 0.2, 0.2, 0.2, 0.2]
world=['green','red','red','green','green']
#First configuration of meas.
# measurements=['red','green']
# motions=[1,1]
#Sencond configuration
measurements=['red','green','green']
motions=[1,1,1]
#Third configuration
# measurements=['green','red']
# motions=[1,1]
#Fourth configuration
# measurements=['green''green']
# motions=[3,1]
#Fifth configuration,It is impossible case
# measurements=['red','red']
# motions=[3,1]
#Sixth configuration,It is impossible case
# measurements=['red','red']
# motions=[2,1]
pHit=0.6
pMiss=0.2
pExact=0.8
pOvershoot=0.1
pUndershoot=0.1
entropy=np.zeros((2,len(motions)))
motions_size=len(motions)
for i in range(len(measurements)):
    #Updara by sensing
    p=sense(p,measurements[i],world,pHit,pMiss)
    entropy[0,i]=-sum(p*np.log2(p))
    p=move(p,motions[i],pExact,pOvershoot,pUndershoot)
    entropy[1,i]=-sum(p*np.log2(p))
print('The final posterior:')
print(p)
print('The final entropy:')
print(entropy[-1,-1])

print(len(motions))

plt.ion()
h1=plt.figure(1)
plt.cla()
hAllBar=plt.bar(x=(1,2,3,4,5),height=p,width=1,facecolor='g',edgecolor='black')
p=p.tolist()
pMaxCell=max(p)
iMaxCell=p.index(pMaxCell)   #提取不到最大值的位置
pMax=np.zeros(len(p))
pMax[iMaxCell]=pMaxCell
hMaxBar=plt.bar(x=(1,2,3,4,5),height=pMax,width=1,facecolor='r',edgecolor='black')
plt.xlabel('Index of cell')
plt.ylabel('Posterior')
plt.xlim(0,5.5,1)
# plt.show(h1)

h2=plt.figure(2)
plt.plot(range(1,motions_size+1),entropy[0,:],'bh',linewidth=3,markersize=10)
plt.plot(range(1,motions_size+1),entropy[1,:],'rx',linewidth=3,markersize=10)
print(entropy[0,:])
print(entropy[1,:])
plt.xlim(-1,(len(motions)+1))
plt.xlabel('Step')
plt.ylabel('Entropy')
plt.legend(('After sensing', 'Before sensing'),loc='upper right')
plt.ioff()
plt.show()