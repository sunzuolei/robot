import numpy as np
p=np.array([1/9,1/3,1/3,1/9,1/9])
u=6    # move steps
# 使用numpy中的roll指令对p进行指定步数u的移位操作
q=np.roll(p,u)
print('Before motion:',p)
print('After motion:',q)
