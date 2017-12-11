import math
nlist=[7, 38, 4, 23, 18]
N=len(nlist)
sum1=0
sum2=0
for i in range(N):
    sum1+=nlist[i]
    sum2+=nlist[i]**2
mean=sum1/N
var=sum2/N-mean**2
print(N)
print('The Expectation / Mean:', format(mean , '.1f'))
print('The Variance is:', format(var , '.1f'))
print('The Standard Deviation is:', format(math.sqrt(var) , '.1f'))
