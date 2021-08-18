import numpy as np
from numpy import tan
from matplotlib import pyplot as plt

def shockCap(th_wr,th_ob):
  
  return z,r

th_wr = np.linspace(0.01,3.142,100)
th_ob = np.linspace(0.01,3.142,100)

tthwr,tthob = np.meshgrid(th_wr,th_ob)

z,r = shockCap(tthwr,tthob)

print(np.shape(z))

plt.plot(z,r)
plt.show()