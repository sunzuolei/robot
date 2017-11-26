import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

def getPositon(a):
    raw, column = a.shape  # get the matrix of a raw and column
    positon = np.argmax(a)  # get the index of max in the a
    # print(positon)
    r, c = divmod(positon , column)
    return r,c

def sence(p,z,world,pSenseCorrect):
    # nRow=len(p[0])
    # nCol=len(p[:0])
    nRow,nCol=np.shape(p)
    q_size=(nRow,nCol)
    q=np.zeros(q_size)
    for r in range(0,nRow):
        for c in range(0,nCol):
            if z== world[r][c]:
                hit=1
            else:
                hit=0
            q[r,c]=p[r,c]*(hit * pSenseCorrect + (1-hit) * (1-pSenseCorrect))
    S=sum(q)
    for i in range(len(q)):
        q[i]=q[i]/sum(S)
    return q

world = (('red', 'green', 'green', 'red', 'red'),
('red', 'red', 'green', 'red', 'red'),
('red', 'red', 'green', 'green', 'red'),
('red', 'red', 'red', 'red', 'red'))
nRow = len(world)
nCol = len(world[1])
print(world[1][1])
pStart = 0.7
ones_size=(nRow,nCol)
ones=np.ones(ones_size)
p = (1 - pStart) / (nRow * nCol - 1) * ones
pSenseCorrect=0.7
p[2,1]=pStart
measurements=['green']
# print(measurements[0])
q=sence(p,measurements[0],world,pSenseCorrect)
print("The Prior:\n",p)
print("The probability after sensing:\n",q)
r,c=getPositon(q)
print('The largest probability %s occurs at cell(%s,%s)\n'%(q[r,c],r,c))

plt.ion()
h=plt.figure(1)
ax=Axes3D(h)
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
ax.bar3d(xpos,ypos,zpos, dx, dy, dz)
plt.ioff()
plt.show()