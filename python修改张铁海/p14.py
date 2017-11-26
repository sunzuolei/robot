import numpy as np

from p13 import compMean  #这种方式引用在使用函数时，前面必须加文件名  compMean.compMean(x)
# import compMean    这种方式引用，使用函数时，前面不用加文件名
a=2
b=4
x=[7,38,4,23,18]
x=np.mat(x)
y=a*x + b
xmu=compMean.compMean(x)
ymu=compMean.compMean(y)
print('a * Xmu + b \t= %s \n'%(a * xmu + b))
print('Ymu \t\t= %.2f \n'%ymu)
