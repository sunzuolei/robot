# -*- coding: utf-8 -*-

import numpy as np
import matplotlib.pyplot as plt
import time
import os
#from threading import Thread



pHead = np.arange(0, 1.01, 0.01)

n = len(pHead)
H = np.zeros(n)

for i in range(0, n):
    p = [pHead[i], 1 - pHead[i]]
    if pHead[i] == 0:
        p = 1 - pHead[i]
    elif 1 - pHead[i] == 0:
        p = pHead[i]
    #用np.round来控制精度
    p = np.round(p, decimals = 3)
    H[i] = -np.sum(p * np.log2(p))
    #modify:修正0.3 % 0.1 = 0.099999999999999978这类python的bug，采用将小数转换为整数的方法
    if pHead[i] * 10 % 1 == 0 and pHead[i] != 0 and pHead[i] != 1:
        plt.ylabel('Probability')
        plt.ylim(0, 1)
        plt.bar(left = (0, 1), height = (p[0], p[1]), width = 1, align='center')
        plt.title('pHead={:.2f}, pTail={:.2f}'.format(pHead[i], 1 - pHead[i]))
        plt.xticks((0, 1), ('pHead', 'pTail'))
        dirpath = os.path.dirname(__file__)
        plt.savefig(dirpath + '\pHead={:.2f}, pTail={:.2f}.png'.format(pHead[i], 1 - pHead[i]))
        plt.show(block = False)
        #plt.show()
        #可自行控制时间
        time.sleep(3)
        plt.close()



        
        
