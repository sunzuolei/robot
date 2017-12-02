import compound
from math import *
from numpy import *
import scipy.io as sio
import matplotlib.pyplot as plt

def compSteer(x,wp,iwp,G,dt):
    maxG = 30*pi/180
    rateG = 20*pi/180
    minD = 0.5
    cwp = wp[:,iwp-1]
    d2 = (cwp[0]-x[0])**2 + (cwp[1]-x[1])**2
    if d2 < minD**2:
        iwp = iwp + 1
        if iwp > len(wp[0]):
            iwp = 0
        cwp = wp[:,iwp-1]

    deltaG = compound.piTopi(atan2(cwp[1]-x[1],cwp[0]-x[0])-x[2]-G)
    maxDelta = rateG * dt

    if abs(deltaG) > maxDelta:
        deltaG = sign(deltaG)*maxDelta

    G = G + deltaG
    if abs(G) > maxG:
        G = sign(G)*maxG

    return G,iwp

if __name__=="__main__":
    #load tim.mat for getting wp
    load_fn = 'tim.mat'
    load_data = sio.loadmat(load_fn)
    wp = load_data['wp']

    steering = 0 # initial steering
    velocity = 4.0 # the velocity of the vehicle
    wheelbase = 8  # the length of wheelbase
    dt = 0.05 # time interval
    iWp = 1 # index to first waypoint
    iPos = 0
    rob = array([[0,-8,-8],[0,-4,4]])
    rob_plot_array = array([[0,-wheelbase,-wheelbase,0],[0,-4,4,0]])

    #Initialize figure
    plt.figure()
    plt.xlabel('X(m)')
    plt.ylabel('Y(m)')
    axes = plt.axes(xlim=(-110,100),ylim=(-110,100))
    axes.plot(wp[0],wp[1],'*g--' ,markersize = 10 ,linewidth = 2)
    axes.plot(wp[0],wp[1],'c:',linewidth = 2)
    robplot ,= axes.plot(rob_plot_array[0],rob_plot_array[1],'b')
    pos = zeros([3, 1])
    path = zeros([3,3390])

    while iWp!= 0:
        steering, iWp = compSteer(pos, wp, iWp, steering, dt)
        pos[0] = pos[0] + velocity * dt * cos(steering + pos[2, :])
        pos[1] = pos[1] + velocity * dt * sin(steering + pos[2, :])
        pos[2] = pos[2] + velocity * dt * sin(steering) / wheelbase
        pos[2] = compound.piTopi(pos[2])
        robPos = compound.compound(pos, rob)
        path[:, iPos + 1] = pos[:, 0]
        iPos += 1
        axes.plot(path[0, 0:iPos], path[1, 0:iPos], 'r-',linewidth = 2)
        axes.plot(robPos[0,0],robPos[1,0])
        b = robPos[0:2, 0:1]
        a = robPos[0:2]
        c = hstack((a, b))
        robplot.set_data(c[0], c[1])
        plt.pause(0.00001)
