#-------by HYH -------#
import numpy as np
import matplotlib.pyplot as plt
world=np.array(['green','red','red','green','green'])
p=np.array([0.2,0.2,0.2,0.2,0.2])
z='green'
pHit=0.6
pMiss=0.2
def plot_P2():
	plt.figure(figsize=(8,10), dpi=80)
	plt.subplot(411)
	plt.bar(x=(0,1,2,3,4),height=p,color='red')
	plt.xlabel('Position')
	plt.ylabel('Probability of being at the positon')
	plt.title('The Prior distribution')
	##
	plt.subplot(412)
	q=np.zeros(np.size(p))
	for i in range(len(p)):
		if z==world[i]:
			hit=1
		else:
			hit=0
		q[i]=hit*pHit+(1-hit)*pMiss
	plt.bar(x=(0,1,2,3,4),height=q,color='blue')
	plt.xlabel('Position')
	plt.ylabel('Likelihood')
	plt.title('Observation model')
	##
	plt.subplot(413)
	q=[p[i]*q[i] for i in range(len(p))]
	plt.bar(x=(0,1,2,3,4),height=q,color='yellow')
	plt.xlabel('Position')
	plt.ylabel('Probability of being at the positon')
	plt.title('The Posterior distribution')
	##
	plt.subplot(414)
	q=q/sum(q)
	plt.bar(x=(0,1,2,3,4),height=q,color='green')
	plt.xlabel('Position')
	plt.ylabel('Probability of being at the positon')
	plt.title('The Posterior distribution')
	plt.subplots_adjust(hspace=0.8)
	plt.show()
plot_P2()