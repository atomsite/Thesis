set terminal cairolatex standalone size 4in,1.2in
set output "gridxz.tex"


autocm=6.6845871e-14

set size ratio 0.16667

set xrange [-1200:1200]
set yrange [-150:150]

set ytics -100,100,100

set xlabel "X (AU)"
set ylabel "Z (AU)"

plot "mesh-7lev.dat" using ($1*autocm):($3*autocm) w l lc rgb "black" notitle
