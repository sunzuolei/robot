
pCan=0.001
pNon=0.999
z='positive'
# z='negative'
pPosCan=0.8
pPosNon=0.1
if z=='positive':
    p=[pPosCan*pCan, pPosNon*pNon]
else:
    p=[(1-pPosCan)*pCan,(1-pPosNon)*pNon]
S=sum(p)
for i in range(len(p)):
    p[i]=p[i]/sum(p)
print(p[0])
print(p[1])
