import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
def getPositon(a):
    raw, column = a.shape  # get the matrix of a raw and column
    positon = np.argmax(a)  # get the index of max in the a
    # print(positon)
    r, c = divmod(positon , column)
    return r,c

def move(p,u,pMoveCorrect):
    nRow=int(len(p))
    nCol=int(len(p[0]))
    q=np.zeros(ones_size)
    for r in range(1,nRow+1):
        for c in range(1,nCol+1):
            q[r-1,c-1]=pMoveCorrect * p[np.mod(r-1-u[0],nRow),np.mod(c-1-u[1],nCol)]+ (1-pMoveCorrect)* p[r-1,c-1]
        # return q
    return q

world = (('red', 'green', 'green', 'red', 'red'),
('red', 'red', 'green', 'red', 'red'),
('red', 'red', 'green', 'green', 'red'),
('red', 'red', 'red', 'red', 'red'))
# print(world)
# print(len(world))
# print(len(world[1]))
nRow = len(world)
nCol = len(world[1])
ones_size=(nRow,nCol)
ones=np.ones(ones_size)
step={
    'stop':[0,0],
    'right':[0,1],
    'left':[0,-1],
    'down':[1,0],
    'up':[-1,0]
}
pMoveCorrect = 0.8
pStart = 0.7
p = (1 - pStart) / (nRow * nCol - 1) * ones
# Fisrt configuration
# p[2,1]=pStart
# motions=step['right']
# Second configuration
p[0,2]=pStart
motions=step['up']

q=move(p,motions,pMoveCorrect)
print('The Prior:\n',p)
print('The probability after moving:\n',q)
r,c=getPositon(q)
print('The largest probability %s occurs at cell(%s,%s)\n'%(q[r,c],r,c))

plt.ion()
h=plt.figure(1)
ax=Axes3D(h)
# x=np.arange(1,nRow+1,1)
# y=np.arange(1,nCol+1,1)
# z=p.flatten()
# x=x.flatten()
# y=y.flatten()
# dx_size=(nRow,nCol)
# dx=np.ones(dx_size)
# dy=dx.copy()
# dz=p.flatten()
# ax.bar3d(x,y,z,dx,dy,dz)
# plt.show()

ly= len(p[0])  #5            # Work out matrix dimensions
lx= len(p[:,0])  #4
xpos = np.arange(0,lx,1)    # Set up a mesh of positions
ypos = np.arange(0,ly,1)
xpos, ypos = np.meshgrid(xpos+0.25, ypos+0.25)
xpos = xpos.flatten()   # Convert positions to 1D array
ypos = ypos.flatten()
zpos = np.zeros(lx*ly)

dx = np.ones_like(zpos)
dy = dx.copy()
dz = p.T.flatten()
ax.bar3d(xpos,ypos,zpos, dx, dy, dz)

h1=plt.figure(2)
ax=Axes3D(h1)
ly= len(q[0])  #5            # Work out matrix dimensions
lx= len(q[:,0])  #4
xpos = np.arange(0,lx,1)    # Set up a mesh of positions
ypos = np.arange(0,ly,1)
xpos, ypos = np.meshgrid(xpos+0.25, ypos+0.25)
xpos = xpos.flatten()   # Convert positions to 1D array
ypos = ypos.flatten()
zpos = np.zeros(lx*ly)

dx = np.ones_like(zpos)
dy = dx.copy()
dz = q.T.flatten()
# color=plt.cm.
ax.bar3d(xpos,ypos,zpos, dx, dy, dz)
plt.ioff()
plt.show()
