from functools import reduce
import athena_read
import numpy as np
import matplotlib.pyplot as plt

def reduceData(data,quant):
  """

  Note: This can be modified to run in 3D, but right I have optimised it for 2d slices
  """
  nindex = np.size(data[quant])
  xdata  = np.empty(nindex)
  ydata  = np.empty(nindex)
  qdata  = np.empty(nindex)
  idx = 0
  for n in range(len(data[quant])):
      for i in range(len(data["x1v"][n])):
        for j in range(len(data["x2v"][n])):
          for k in range(len(data["x3v"][n])):
            xdata[idx] = data["x1v"][n][i]
            ydata[idx] = data["x2v"][n][j]
            qdata[idx] = data[quant][n][k][j][i]
            idx += 1
  return xdata,ydata,qdata

data = athena_read.athdf("amr.out1.00020.athdf",raw = True)
rho = reduceData(data,"rho")

plt.rcParams.update({
    "text.usetex": True,
    "font.family": "serif"
})

plt.figure(figsize=(6,2))
ax = plt.gca()
ax.set_aspect(1)

cs = plt.tricontourf(*rho,levels=256)
for c in cs.collections:
  c.set_rasterized(True)

x = []
y = []
z = []
with open("mesh_structure.dat") as f:
    for line in f:
        if line[0] != '\n' and line[0] != '#':
            numbers_str = line.split()
            x.append(float(numbers_str[0]))
            y.append(float(numbers_str[1]))
            # append zero if 2D
            if(len(numbers_str) > 2):
                z.append(float(numbers_str[2]))
            else:
                z.append(0.0)
        if line[0] == '\n' and len(x) != 0:
            plt.plot(x, y, 'w',linewidth=0.5)
            x = []
            y = []
            z = []

plt.xlabel("X")
plt.ylabel("Y")

# plt.colorbar(label=r"$\rho$",ticks=np.linspace(0,))

plt.savefig("plot.pdf",dpi=600,bbox_inches="tight")