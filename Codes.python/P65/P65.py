#-------by HYH -------#
import numpy as np
import matplotlib.pyplot as plt
pHead=np.arange(0,1.01,0.01)
n=len(pHead)
H=np.zeros(n)
fig1=plt.figure(figsize=(10,10),dpi=80)
plt.ion()
for i in range(n):
	p=[pHead[i],1-pHead[i]]
	if pHead[i]==0:
		p=1-pHead[i]
	elif pHead[i]==1:
		p=pHead[i]
	H[i]=-np.sum(p*np.log2(p))
	if pHead[i]%0.1==0 and pHead[i]!=0 and pHead[i]!=1:
	#取余在pHead[i]=0.3,0.5,0.6,0.7,0.9处不等于0..和matlab不一样，解决不了这个问题
		plt.cla()
		plt.bar(x=(0,1),height=p,width=0.8)
		plt.ylim(0,1)
		plt.xticks(np.arange(2),('pHead','pTail'))
		plt.ylabel('Probability')
		plt.title('pHead=%s,pTail=%s'%(pHead[i],1-pHead[i]))
		print(i,'\n',p)
		plt.pause(0.2)
fig2=plt.figure(figsize=(10,10),dpi=80)
plt.plot(pHead,H,'r-')
plt.grid(True,linestyle='-.',color='k')
plt.xlim(0,1)
plt.ylim(0,1)
plt.xlabel('The probability of being head')
plt.ylabel('Entropy')
plt.ioff()
plt.show()