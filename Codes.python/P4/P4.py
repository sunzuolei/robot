#-------by HYH -------#
import numpy as np
p=[1/9,1/3,1/3,1/9,1/9]
u=6
def move(p,u):
	n=len(p)
	q=np.zeros(n)
	for i in range(n):
		q[i]=p[(i-u)%n]
	return q
q=move(p,u)
print(q)