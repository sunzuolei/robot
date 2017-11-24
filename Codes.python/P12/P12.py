#-------by HYH -------#
import numpy as np
pCan=0.001
pNon=0.999
pPosCan=0.8
pPosNon=0.1
z='positive'
if 'positive'==z:
	p=[pPosCan*pCan,pPosNon*pNon]
else:
	p=[(1-pPosCan)*pCan,(1-pPosNon)*pNon]
p=p/np.sum(p)
print('The probability of having cancer given the %s test:\n'% z,'\n',p[0])
print('The probability of cancer free given the %s test:\n'%z,'\n',p[1])