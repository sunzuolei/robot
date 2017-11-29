import numpy as np
def move(p, u, pExact, pOvershoot, pUndershoot):
    q=(np.roll(p,u)*pExact)+(np.roll(p,u+1)*pOvershoot)+(np.roll(p,u-1)*pUndershoot)
    return q
p = np.array([0, 0.5, 0, 0.5, 0])
u = 2
pExact = 0.8
pOvershoot = 0.1
pUndershoot = 0.1
q=move(p, u, pExact, pOvershoot, pUndershoot)
print(p)
print(q)
