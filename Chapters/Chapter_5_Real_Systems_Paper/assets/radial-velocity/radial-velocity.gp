# GnuPlot script for plotting single wind densities as a function of distance from the star, wind plotted using a function requiring the wind mass loss rate in solarmass/year and wind terminal velocity in km/s, this assumes a smooth isothermal wind.

# Setup plot, using palette in previous folder and cariolatex terminal
load "turbo.pal"
set terminal cairolatex standalone size 5in,3in
set output "radial.tex"

set grid

set xrange [0.95:1.10]
set yrange [-100:100]

set xlabel "$\\Phi$"
set ylabel "$v_{r}$ (km s$^{-1}$)"

set key bottom right

plot "radial.dat" using 1:2 w l ls 1 title "WR" ,\
     "" using 1:3 w l ls 2 title "OB" ,\
  #   "" using 1:4 w l ls 3 title "Total"