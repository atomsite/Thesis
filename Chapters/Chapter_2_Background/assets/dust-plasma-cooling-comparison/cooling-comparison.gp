# Plot a series of normalised plasma and dust cooling curves, calculating the cooling rate 

set terminal cairolatex standalone size 5in,3in mono
set output "cooling-comparison.tex"

set logscale xy
set format xy '$10^{%L}$'
set ylabel '$\frac{dE}{dt}$(T) (erg cm$^3$ s$^{-1}$)'
set xlabel 'T(K)'
set xrange[1e4:1e9]
#set yrange [1e-26:2e-10]

z      = 1e-2
dens_g = 3.0  
rho    = 1.0e-20
mH     = 1.67e-24
np     = rho*(10.0/14.0)/mH

calcmD(a)    = (4.0/3.0)*pi*(a**3)*dens_g
calcnd(z,mD) = rho*z/mD

set style fill transparent solid 0.5 noborder
set colorsequence podo
set key bottom right

plot "cooling_curve_solar.dat" u (10**$1):($2*(rho/mH)**2) t "Solar plasma" w l ,\
  "dust_cool_0.01micron.dat" u (10**$1):($2*calcnd(z,calcmD(0.01*1e-4))*np) t "Dust a = 0.01 $\\mu$m" w l ,\
  "dust_cool_0.1micron.dat"  u (10**$1):($2*calcnd(z,calcmD(0.10*1e-4))*np) t "Dust a = 0.10 $\\mu$m" w l ,\
  "dust_cool_1.0micron.dat"  u (10**$1):($2*calcnd(z,calcmD(1.00*1e-4))*np) t "Dust a = 1.00 $\\mu$m" w l
