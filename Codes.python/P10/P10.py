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
pStart=0.7
p=(1-pStart)/(nRow*nCol-1)*np.ones([nRow,nCol])
pSenseCorrect=0.7
##
p[2][1]=pStart
measurements=['green']
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
def maxMat(g):
	r=g.argmax(axis=0)
	temp=g[r,range(g.shape[1])]
	index_Row=np.argsort(temp)
	c=index_Row[len(index_Row)-1]
	r=r[c]
	return r,c
##
q=sense(p,measurements[0],world,pSenseCorrect)
print('The Prior:','\n',p)
print('The probability after sensing:','\n',q)
r,c=maxMat(q)
print('The largest probability %s occurs at cell (%s, %s)\n'%(q[r][c],r,c))
##
p=p.T 
q=q.T
color=color.T
_x=np.arange(1,5)
_y=np.arange(1,6)
_xx,_yy=np.meshgrid(_x,_y)
x,y=_xx.ravel(),_yy.ravel()
p=p.reshape(1,-1)
p=p.tolist()
p=sum(p,[])
q=q.reshape(1,-1)
q=q.tolist()
q=sum(q,[])
color=color.reshape(1,-1)
color=color.tolist()
color=sum(color,[])
##
plt.ion()
fig1=plt.figure(figsize=(10,10),dpi=80,)
ax=Axes3D(fig1)
ax.bar3d(x,y,z=np.zeros_like(p),dx=1,dy=1,dz=p,color=color,shade=True)
plt.title('The prior')
fig2=plt.figure(figsize=(10,10),dpi=80,)
##
ax=Axes3D(fig2)
ax.bar3d(x,y,z=np.zeros_like(q),dx=1,dy=1,dz=q,color=color,shade=True)
plt.title('The probability distribution after moving')
plt.ioff()
plt.show()