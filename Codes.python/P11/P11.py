#-------by HYH -------#
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
##
world=np.array([['red','green','green','red',  'red'],
                ['red','red',  'green','red',  'red'],
                ['red','red',  'green','green','red'],
                ['red','red',  'red',  'red',  'red']])
color=np.array([['r','b','g','w','y'],
	            ['r','b','g','w','y'],
	            ['r','b','g','w','y'],
	            ['r','b','g','w','y']])
nRow,nCol=np.shape(world)
stop=[0,0]
right=[0,1]
left=[0,-1]
down=[1,0]
up=[-1,0]
pMoveCorrect=0.8
pSenseCorrect=0.7
compEntropy=lambda p:-np.sum(np.sum(p*np.log2(p)))
p=1/(nRow*nCol)*np.ones([nRow,nCol])
##
motions=[stop, right, down, down, right]
measurements=['green','green','green','green','green']
##
def sense(p,z,world,pSenseCorrect):
	nRow,nCol=np.shape(p)
	q=np.zeros([nRow,nCol])
	for r in range(nRow):
		for c in range(nCol):
			if z==world[r][c]:
				hit=1
			elif z!=world[r][c]:
				hit=0
			q[r][c]=p[r][c]*(hit*pSenseCorrect+(1-hit)*(1-pSenseCorrect))
	q=q/sum(sum(q))
	return q

##
def move(p,u,pMoveCorrect):
	nRow,nCol=np.shape(p)
	q=np.zeros([nRow,nCol])
	for r in range(nRow):
		for c in range(nCol):
			q[r][c]=pMoveCorrect*p[(r-u[0])%nRow][(c-u[1]%nCol)]+(1-pMoveCorrect)*p[r][c]
	return q
##
def maxMat(g):
	r=g.argmax(axis=0)
	temp=g[r,range(g.shape[1])]
	index_Row=np.argsort(temp)
	c=index_Row[len(index_Row)-1]
	r=r[c]
	return r,c
##
assert len(motions)==len(measurements),'The variable ''motions'' should be of the same size as ''measurements''!'
entropy=np.zeros([2,len(motions)])	
##
plt.ion()
fig1=plt.figure(figsize=(10,10),dpi=80)
_x=np.arange(1,5)
_y=np.arange(1,6)
_xx,_yy=np.meshgrid(_x,_y)
x,y=_xx.ravel(),_yy.ravel()
for i in range(len(motions)):
	ax=fig1.add_subplot(2,1,1, projection='3d')
	ax.cla()
	p=move(p,motions[i],pMoveCorrect)
	p0=p
	p=sense(p,measurements[i],world,pSenseCorrect)
	p1=p
	entropy[:,i]=[compEntropy(p0),compEntropy(p1)]
	p0=p0.T 
	p1=p1.T
	color0=color.T
	p0=p0.reshape(1,-1)
	p0=p0.tolist()
	p0=sum(p0,[])
	p1=p1.reshape(1,-1)
	p1=p1.tolist()
	p1=sum(p1,[])
	color0=color0.reshape(1,-1)
	color0=color0.tolist()
	color0=sum(color0,[])
	ax.bar3d(x,y,z=np.zeros_like(p0),dx=1,dy=1,dz=p0,color=color0,shade=True)
	ax.set_title('Step %s\n The probability before sensing'%(i+1))
	ax.set_zlim3d(0,0.3)
	ax.set_ylim3d(0.5,4.5)
	ax=fig1.add_subplot(2,1,2, projection='3d')
	ax.bar3d(x,y,z=np.zeros_like(p1),dx=1,dy=1,dz=p1,color=color0,shade=True)
	plt.title('The probability after sensing')
	ax.set_zlim3d(0,0.3)
	ax.set_ylim3d(0.5,4.5)
	plt.pause(1)
##
print('The Posterior:','\n',p)
r,c=maxMat(p)
print('The largest probability %s occurs at cell (%s, %s)\n'%(p[r][c],r,c))
fig2=plt.figure(figsize=(10,10),dpi=80)
plt.plot(range(1,len(motions)+1),entropy[0,:],'bo',MarkerSize=10,label='After sensing')
plt.plot(range(1,len(motions)+1),entropy[1,:],'rx',MarkerSize=10,label='Before sensing')
plt.xlim(0,len(motions)+1)
plt.xlabel('Step')
plt.ylabel('Entropy')
plt.legend()
plt.ioff()
plt.show()