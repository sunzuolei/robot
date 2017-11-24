#-------by HYH -------#
import numpy as np
import matplotlib.pyplot as plt
p=[1,0,0,0,0]
u=1
step=100
pExact=0.8
pOvershoot=0.1
pUndershoot=0.1
entropy=np.zeros(step)
plt.figure(figsize=(10,10),dpi=80)
def move(p,u,pExact,pOvershoot,pUndershoot):
	n=len(p)
	q=np.zeros(n)
	for i in range(n):
		q[i]=pExact*p[(i-u)%n]
		q[i]=q[i]+pOvershoot*p[(i-1-u)%n]
		q[i]=q[i]+pUndershoot*p[(i+1-u)%n]
	return q
for i in range(step):
	p=move(p,u,pExact,pOvershoot,pUndershoot)
	entropy[i]=-np.sum(p*np.log2(p))
	print(i+1,'\n',p)
x=np.arange(0,step)
plt.plot(x,entropy,'g-',x,entropy,'r^')
plt.xlabel('Motion step')
plt.ylabel('Entropy')
plt.show()
