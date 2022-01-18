"""
Polynomial fit generator for various types of dust grain

Fits derived from:
Tielens, A. G. G. M., McKee, C. F., Seab, C. G., & Hollenbach, D. J. (1994). The physics of grain-grain collisions and gas-grain sputtering in interstellar shocks. The Astrophysical Journal, 431, 321. https://doi.org/10.1086/174488
"""

from numpy import logspace,linspace,log10,column_stack,savetxt
import matplotlib.pyplot as plt

def plot_poly(x,coeffs):
  o = len(coeffs)
  y = 0
  for i in range(o):
    y += coeffs[i]*x**i
  return y

class poly:
  def __init__(self,name,a0,a1,a2,a3,a4,a5):
    self.a0          = a0
    self.a1          = a1
    self.a2          = a2
    self.a3          = a3
    self.a4          = a4
    self.a5          = a5
    self.coeffs      = (a0,a1,a2,a3,a4,a5)
    self.t_data      = linspace(-2,2.2,1000)
    self.yield_data  = plot_poly(self.t_data,self.coeffs)
    self.t_data     += 6
    self.yield_data -= 4
    self.tau_data    = -self.yield_data
    self.t_data      = 10**self.t_data
    self.yield_data  = 10**self.yield_data
    self.tau_data    = 10**self.tau_data
    self.export_data = column_stack((self.t_data,self.yield_data,self.tau_data))
    savetxt("{}.dat".format(name),self.export_data,delimiter=" ")
    return
  def fit(self):
    t_data     = self.t_data
    # print(t_data)
    yield_data = self.a0 + self.a1*t_data + self.a2*t_data**2 + self.a3*t_data**3 + self.a4*t_data**4 + self.a5*t_data**5
    return yield_data

silicate_fit = poly("silicate",-2.7446,1.5439,-0.37046,0.21641,-0.34755,0.10114)
graphite_fit = poly("graphite",-2.8605,1.0572,-0.27545,0.23735,-0.31820,0.087376)
sic_fit      = poly("SiC",-3.0862,1.3984,-0.4119,0.3438,-0.3778,0.0990)
ice_fit      = poly("ice",-1.1023,0.7074,-0.2041,0.04298,-0.05124,0.0140)
iron_fit     = poly("iron",-3.2944,1.4978,-0.2614,0.2447,-0.3338,0.0898)