#-------by HYH -------#
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
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
pStart=0.7
p=(1-pStart)/(nRow*nCol-1)*np.ones([nRow,nCol])
# p[2][1]=pStart
# motions=[right]
##
p[0][2]=pStart;
motions=[up]
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
	r=g.argmax(axis=0)   ##按列求最大，返回每列最大值所在行的索引
	temp=g[r,range(g.shape[1])]  ##返回每列最大值
	index_Row=np.argsort(temp)  ##列最大的索引按升序排序
	c=index_Row[len(index_Row)-1]  ##最大值的列索引
	r=r[c]  ##最大值行索引
	return r,c
##生成Q,P矩阵
q=move(p,motions[0],pMoveCorrect)
print('The Prior:','\n',p)
print('The probability after moving:','\n',q)
r,c=maxMat(q)
print('The largest probability %s occurs at cell (%s, %s)\n'%(q[r][c],r,c))
##准备数据
p=p.T ##转置是为了后面输出z在网格上是能对应矩阵形式，因为bar3填充数据是列向填，将矩阵装换成列表是行向转换
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