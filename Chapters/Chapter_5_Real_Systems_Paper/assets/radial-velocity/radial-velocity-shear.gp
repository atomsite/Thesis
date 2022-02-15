# GnuPlot script for plotting single wind densities as a function of distance from the star, wind plotted using a function requiring the wind mass loss rate in solarmass/year and wind terminal velocity in km/s, this assumes a smooth isothermal wind.

# Setup plot, using palette in previous folder and cariolatex terminal
load "turbo.pal"
set terminal cairolatex standalone size 5in,3in
set output "radial-shear.tex"

set grid

set xrange [0.50:1.50]
set yrange [-100:100]

set xlabel "$\\Phi$"
set ylabel "$v_{r}$ (km s$^{-1}$)"

set key bottom right


vwr=2.86e3
vob=3.20e3

set y2tics
set y2range [1.10:1.14]
set y2label "$\\Upsilon$
set y2tics 1.10,0.01,1.14
set format y2 "${%.2f}$"

set format x  "${%.1f}$"

plot "radial.dat" using 1:2 w l ls 1 title "WR" ,\
     "" using 1:3 w l ls 2 title "OB" ,\
     "" using 1:(($3+vob)/($2+vwr)) w l ls 3 dashtype "-" title "$\\Upsilon$" axes x1y2