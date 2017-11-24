#-------by HYH -------#
import numpy as np
p=[0,0.5,0,0.5,0]
u=2
pExact=0.8
pOvershoot=0.1
pUndershoot=0.1
def move(p,u,pExact,pOvershoot,pUndershoot):
	n=len(p)
	q=np.zeros(n)
	for i in range(n):
		q[i]=pExact*p[(i-u)%n]
		q[i]=q[i]+pOvershoot*p[(i-1-u)%n]
		q[i]=q[i]+pUndershoot*p[(i+1-u)%n]
	return q
q=move(p, u, pExact, pOvershoot, pUndershoot)
print(q)