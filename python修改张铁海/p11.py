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

def compEntropy(p):
    compEntropy = -sum(sum(p * np.log2(p)))
    return compEntropy


world = (('red', 'green', 'green', 'red', 'red'),
('red', 'red', 'green', 'red', 'red'),
('red', 'red', 'green', 'green', 'red'),
('red', 'red', 'red', 'red', 'red'))
nRow = len(world)
nCol = len(world[1])
print(nRow,nCol)
step={
    'stop':[0,0],
    'right':[0,1],
    'left':[0,-1],
    'down':[1,0],
    'up':[-1,0]
}
pMoveCorrect = 0.8
pSenseCorrect=0.7
ones_size=(nRow,nCol)
ones=np.ones(ones_size)
p = 1/ (nRow * nCol) * ones
# compEntropy=-sum(sum(p * np.log2(p)))

#First configuration
motions=[step['stop'],step['right'],step['down'],step['down'],step['right']]
measurements=['green','green','green','green','green']
#Check the size
if len(motions)!= len(measurements):
    print("The variable 'motions' should be of the same size as 'measurements' ! ")
entropy_size=(2,len(motions))
entropy=np.zeros(entropy_size)
#The main loop
plt.ion()
for i in range(0,len(motions)):
    # plt.ion()
    p=move(p,motions[i],pMoveCorrect)
    p0=p
    p=sence(p,measurements[i],world,pSenseCorrect)
    #Compute entropy
    entropy[:,i]=[compEntropy(p0),compEntropy(p)]
    # Make figures
    h=plt.figure(1)
    ax1=h.add_subplot(2,1,1,projection='3d')
    # ax = Axes3D(h)
    plt.cla()
    plt.title('Step %s\n The probability before sensing'%i)
    ly = len(p0[0])  # 5            # Work out matrix dimensions
    lx = len(p0[:, 0])  # 4
    xpos = np.arange(0, lx, 1)  # Set up a mesh of positions
    ypos=(1,2,3,4,5)
    xpos, ypos = np.meshgrid(xpos, ypos)
    xpos = xpos.flatten()  # Convert positions to 1D array
    ypos = ypos.flatten()
    zpos = np.zeros(lx * ly)

    dx = np.ones_like(zpos)
    dy = dx.copy()
    dz = p0.T.flatten()
    # ax1.set(color='r,b,g')
    ax1.bar3d(xpos, ypos, zpos, dx, dy, dz,color='b',alpha=0.6)

    ax2=h.add_subplot(2,1,2,projection='3d')
    ly = len(p[0])  # 5            # Work out matrix dimensions
    lx = len(p[:, 0])  # 4
    xpos = np.arange(0, lx, 1)  # Set up a mesh of positions
    ypos = np.arange(0, ly, 1)
    xpos, ypos = np.meshgrid(xpos, ypos)
    xpos = xpos.flatten()  # Convert positions to 1D array
    ypos = ypos.flatten()
    zpos = np.zeros(lx * ly)
    dx = np.ones_like(zpos)
    dy = dx.copy()
    dz = p.T.flatten()
    # plt.cla()
    col=np.arange(30)
    # plt.scatter(xpos,ypos,zpos,c=col)
    ax2.bar3d(xpos, ypos, zpos, dx, dy, dz,color='g',alpha=0.6)
    plt.pause(0.5)

print('The Posterior:\n',p)
r,c=getPositon(p)
print('The largest probability %.4f occurs at cell (%d, %d)\n '%(p[r,c],r,c))

h2=plt.figure(2)
motions_size=len(motions)
plt.plot(range(1,motions_size+1),entropy[0,:],'bh',linewidth=3,markersize=10)
plt.plot(range(1,motions_size+1),entropy[1,:],'rx',linewidth=3,markersize=10)

plt.xlim(0,(len(motions)+1))
plt.xlabel('Step')
plt.ylabel('Entropy')
plt.legend(('After sensing', 'Before sensing'),loc='upper right')
plt.ioff()
plt.show()