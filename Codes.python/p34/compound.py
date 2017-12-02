import numpy as np
from math import*
def compound(Xwa,Xab):
    Xwb = np.array(np.zeros([3,3]))
    rot = np.array([[cos(Xwa[2,0]),-sin(Xwa[2,0] )],
                  [sin(Xwa[2,0]), cos(Xwa[2,0])]])
    Xwb[0:2] = rot.dot(np.array([Xab[0],Xab[1]])) + np.tile([Xwa[0:2]],(1, len(Xab[0])))
    row = np.shape(Xab)
    if row[0] == 3:
        Xwb[2] = piTopi(Xwa[2] + Xab[2])
    return Xwb

def piTopi(angle):
    twopi = 2*pi
    angle = angle - twopi * int(angle/twopi)
    i1 = np.where(angle >= pi)
    angle[i1] = angle[i1] - twopi

    i2 = np.where(angle < -pi)
    angle[i2] = angle[i2] + twopi
    return angle

# a =np.array([[5],[3],[5*pi/18]])
# b =np.array([[4],[2],[pi/9]])
# print compound(a,b)