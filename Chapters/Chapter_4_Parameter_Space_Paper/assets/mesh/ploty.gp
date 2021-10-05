set terminal cairolatex standalone size 1.2in,4in
set output "gridzy.tex"


autocm=6.6845871e-14

set size ratio 8

set yrange [-1200:1200]
set xrange [-150:150]

set xtics 0,1,0

set xlabel "Z (AU)"
set ylabel "Y (AU)"

plot "mesh-7lev.dat" using ($3*autocm):($2*autocm) w l lc rgb "black" notitle
