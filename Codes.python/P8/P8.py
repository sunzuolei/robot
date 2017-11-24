#-------by HYH -------#
import numpy as np
import matplotlib.pyplot as plt
p=[0.2,0.2,0.2,0.2,0.2]
world=['green','red','red','green','green']
measurements=['red','green']
motions=[1,1]
pHit = 0.6                   
pMiss = 0.2
pExact = 0.8
pOvershoot = 0.1
pUndershoot = 0.1
entropy=np.zeros((2,len(motions)))
##
def sense(p,z,world,pHit,pMiss):
	q=np.zeros(np.size(p))
	for i in range(len(p)):
		if z==world[i]:
			hit=1
		else:
			hit=0
		q[i]=p[i]*(hit*pHit+(1-hit)*pMiss)
	q=q/np.sum(q)
	return q
##
def move(p,u,pExact,pOvershoot,pUndershoot):
	n=len(p)
	q=np.zeros(n)
	for i in range(n):
		q[i]=pExact*p[(i-u)%n]
		q[i]=q[i]+pOvershoot*p[(i-1-u)%n]
		q[i]=q[i]+pUndershoot*p[(i+1-u)%n]
	return q
##
for i in range(len(measurements)):
	p=sense(p,measurements[i],world,pHit,pMiss)
	entropy[0][i]=-np.sum(p*np.log2(p))
	p=move(p,motions[i],pExact,pOvershoot,pUndershoot)
	entropy[1][i]=-np.sum(p*np.log2(p))
##
index_p=np.argsort(p)
pMax=np.zeros(len(p))
pMax[index_p[len(p)-1]]=p[index_p[len(p)-1]]
##
print('The final posterior:','\n',p)
print('The final entropy:','\n',entropy[-1][-1])
##
plt.ion()
fig1=plt.figure(figsize=(10,10),dpi=80)
plt.bar(x=(0,1,2,3,4),height=p,color='g')
plt.bar(x=(0,1,2,3,4),height=pMax,color='r')
plt.xlabel('Index of cell')
plt.ylabel('Posterior')
##
fig2=plt.figure(figsize=(10,10),dpi=80)
plt.plot(range(1,len(motions)+1),entropy[0,:],'bo',MarkerSize=10,label='After sensing')
plt.plot(range(1,len(motions)+1),entropy[1,:],'rx',MarkerSize=10,label='Before sensing')
plt.xlim(0,len(motions)+1)
plt.xlabel('Step')
plt.ylabel('Entropy')
plt.legend()
plt.ioff()
plt.show()
