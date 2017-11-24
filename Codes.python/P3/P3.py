#-------by HYH -------#
import numpy as np
import matplotlib.pyplot as plt
def plot_P2():
	world=np.array(['green','red','red','green','green'])
	p=np.array([0.2,0.2,0.2,0.2,0.2])
	measurements=['red','red','green']
	pHit=0.6
	pMiss=0.2
	plt.ion()
	for i in range(len(measurements)):
		plt.figure(figsize=(8,10), dpi=80)
		plt.subplot(411)
		plt.bar(x=(0,1,2,3,4),height=p,color='red')
		plt.xlabel('Position')
		plt.ylabel('Probability of being at the positon')
		plt.title('The Prior distribution in %s'%measurements[i])
		##
		plt.subplot(412)
		q=np.zeros(np.size(p))
		for j in range(len(p)):
			if measurements[i]==world[j]:
				hit=1
			else:
				hit=0
			q[j]=hit*pHit+(1-hit)*pMiss
		plt.bar(x=(0,1,2,3,4),height=q,color='blue')
		plt.xlabel('Position')
		plt.ylabel('Likelihood')
		plt.title('Observation model in %s'%measurements[i])
		##
		plt.subplot(413)
		q=[p[k]*q[k] for k in range(len(p))]
		plt.bar(x=(0,1,2,3,4),height=q,color='yellow')
		plt.xlabel('Position')
		plt.ylabel('Probability of being at the positon')
		plt.title('The Posterior distribution in %s'%measurements[i])
		##
		plt.subplot(414)
		q=q/sum(q)
		plt.bar(x=(0,1,2,3,4),height=q,color='green')
		plt.xlabel('Position')
		plt.ylabel('Probability of being at the positon')
		plt.title('The Posterior distribution in %s'%measurements[i])
		plt.subplots_adjust(hspace=0.8)
		p=q
	plt.ioff()
	plt.show()
plot_P2()