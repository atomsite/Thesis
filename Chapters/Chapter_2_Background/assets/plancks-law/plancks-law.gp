# Setup plot, using palette in previous folder and cariolatex terminal
load "../turbo.pal"
set terminal cairolatex standalone size 5in,3in
set output "plancks-law.tex"
# Set high number of samples for smooth plot
set samples 1000


#constants
h = 6.62606876e-34   # Planck's constant
c = 2.99792458e8   # speed of light
k = 1.3806503e-23   # Boltzmann's constant

Planck(x,t) = \
 (2*h*c*c/x**5)*(1/(exp(1*h*c/(x*k*t))-1))

set xrange[0:2250]
set yrange[1e6:1e19]
set logscale y
set format y '$10^{%L}$'

set xlabel "$\\lambda$ (\\AA)"
set ylabel "$B$ (Wsr$^{-1}$m$^{-3}$)"

set arrow from 977,1e6 to 977,1e19 nohead lc rgb 'green' lw 0.1
set arrow from 1548.2,1e6 to 1548.2,1e19 nohead lc rgb 'green' lw 0.1
set arrow from 1550.7,1e6 to 1550.7,1e19 nohead lc rgb 'green' lw 0.1
set arrow from 989,1e6 to 989,1e19 nohead lc rgb 'green' lw 0.1
set arrow from 1238.8,1e6 to 1238.8,1e19 nohead lc rgb 'green' lw 0.1
set arrow from 1242.8,1e6 to 1242.8,1e19 nohead lc rgb 'green' lw 0.1
set arrow from 1393.7,1e6 to 1393.7,1e19 nohead lc rgb 'green' lw 0.1
set arrow from 1402.7,1e6 to 1402.7,1e19 nohead lc rgb 'green' lw 0.1
set arrow from 1190.2,1e6 to 1190.2,1e19 nohead lc rgb 'green' lw 0.1
set arrow from 1062.7,1e6 to 1062.7,1e19 nohead lc rgb 'green' lw 0.1
set arrow from 933.4,1e6 to 933.4,1e19 nohead lc rgb 'green' lw 0.1
set arrow from 944.5,1e6 to 944.5,1e19 nohead lc rgb 'green' lw 0.1

set object 1 rect from 933,1e0 to 1550,1e19 fc rgb "light-green" fillstyle transparent solid 0.25 noborder

set key bottom right

set xtics 250

set grid x y mx my 

plot Planck(x*1e-10,5000)  ls 2 t "5,000K",\
     Planck(x*1e-10,10000) ls 3 t "10,000K",\
     Planck(x*1e-10,25000) ls 4 t "25,000K",\
     Planck(x*1e-10,50000) ls 5 t "50,000K"