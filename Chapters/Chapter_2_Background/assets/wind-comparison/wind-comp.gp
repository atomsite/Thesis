# GnuPlot script for plotting single wind densities as a function of distance from the star, wind plotted using a function requiring the wind mass loss rate in solarmass/year and wind terminal velocity in km/s, this assumes a smooth isothermal wind.

# Setup plot, using palette in previous folder and cariolatex terminal
load "../turbo.pal"
set terminal cairolatex standalone size 5in,3in
set output "wind-comp.tex"
# Set high number of samples for smooth plot
set samples 1000
# Conversion constants
msolyrtogs = 6.3010252e25
autocm  = 1.4959787e13
pi      = 3.1415927
kmstocms = 100000
# Function for plotting single wind densities
rho(r,mdot,vinf) = (mdot*msolyrtogs)/(4*pi*((r*autocm)**2)*(vinf*kmstocms))
# Set y axis parameters
set logscale y
set format y '$10^{%L}$'
set ylabel "$\\rho_w$ (g cm$^{-3}$)"
# Set z axis parameters
set xlabel "$d$ (AU)"
set xrange [0:1000]

plot rho(x,1e-5,1500) ls 4 t "Wolf-Rayet" ,\
     rho(x,1e-7,30) ls 2 t "Red Giant" ,\
     rho(x,1e-7,2500) ls 3 t "OB" ,\
     rho(x,1e-14,400) ls 1 t "Solar" 
