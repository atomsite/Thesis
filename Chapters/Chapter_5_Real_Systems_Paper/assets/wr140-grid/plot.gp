set terminal cairolatex standalone size 5in,5in
set output "gridxy.tex"


autocm=6.6845871e-14

set size ratio 1

set xrange [-75:75]
set yrange [-75:75]

set xlabel "X (AU)"
set ylabel "Y (AU)"

plot "mesh_structure.dat" using ($1*autocm):($2*autocm) w l lc rgb "black" notitle
