p=[1/9, 1/3, 1/3, 1/9, 1/9]
u=6
def move(p,u):
    n=len(p)# n=int(len(p))
    q=[] #numpy.zeros(n)
    for i in range(1,n+1):
        x,y=divmod(i-1-u,n)
        q.append(p[y])
    print("Before movtion:\n",p)
    print("After movtion:\n",q)
move(p,u)
