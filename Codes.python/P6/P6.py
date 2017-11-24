#-------by HYH -------#
import numpy as np
import matplotlib.pyplot as plt
import time
p=[1,0,0,0,0]
u=1
step=100
pExact=0.8
pOvershoot=0.1
pUndershoot=0.1
plt.ion()
def move(p,u,pExact,pOvershoot,pUndershoot):
	n=len(p)
	q=np.zeros(n)
	for i in range(n):
		q[i]=pExact*p[(i-u)%n]
		q[i]=q[i]+pOvershoot*p[(i-1-u)%n]
		q[i]=q[i]+pUndershoot*p[(i+1-u)%n]
	return q
for i in range(step):
	p=move(p, u, pExact, pOvershoot, pUndershoot)
	print(i+1,'\n',p)
	plt.cla()
	plt.bar(x=(0,1,2,3,4),height=p)
	plt.axis([-1,5,0,0.8])#上界建议为0.8
	plt.ylabel('Probability')
	plt.title('step=%s'%(i+1))
	plt.pause(0.1)
plt.ioff()
plt.show()
