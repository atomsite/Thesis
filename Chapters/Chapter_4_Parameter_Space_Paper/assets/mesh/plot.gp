set terminal cairolatex standalone size 4in,4in
set output "gridxy.tex"


autocm=6.6845871e-14

set size ratio 1

set xrange [-1200:1200]
set yrange [-1200:1200]

set xlabel "X (AU)"
set ylabel "Z (AU)"

plot "mesh-7lev.dat" using ($1*autocm):($2*autocm) w l lc rgb "black" notitle
