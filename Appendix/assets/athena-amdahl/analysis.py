import numpy as np
from scipy.optimize import curve_fit
import matplotlib.pyplot as plt

cells = 2852 * 40 * 40 * 10 * 10

print(cells)

data = np.genfromtxt("bench.csv",delimiter=",",skip_header=1)
cores     = data[:21,-1]
times     = data[:21:,1]
scoretime = 1135.876
speedup   = scoretime/times
perf = cells/(times*cores)

print(perf)

def amdahl(s,p):
  return 1.0/(1.0-p+(p/(s)))

popt,pcov = curve_fit(amdahl,cores,speedup)
p = popt[0]

xd = np.logspace(0,5,100)

plt.semilogx(xd,amdahl(xd,*popt))
plt.scatter(cores,speedup)

# plt.ylabel("Cells/s/thread")

# plt.plot(cores,speedup)

plt.show()

print(popt,pcov)