set terminal cairolatex standalone size 5in,3in
set output "wr140-orbit.tex"
load "turbo.pal"

autocm=6.6845871e-14

set size ratio -1
set grid

set xlabel "X (AU)"
set ylabel "Y (AU)"

set yrange [-7.5:7.5]
set xtics 5
set ytics 5

plot "< echo '0 0'" lt 2 lc rgb "black" notitle ,\
     "orbit.dat" using 2:3 w l ls 1 dt "." notitle  ,\
     "orbit.dat" using 4:5 w l ls 2 dt "." notitle ,\
     "orbit-sim.dat" using 2:3 w l ls 1 title "WR" ,\
     "< echo '4.665546766443406490e+00 -4.074109352257654137e+00'" lt 2 lw 4 lc rgb '#1f77b4' notitle ,\
     "< echo '-2.066356367310589359e+00 1.804410548771495648e+00'" lt 2 lw 4 lc rgb '#ff7f0e' notitle ,\
     "orbit-sim.dat" using 4:5 w l ls 2 title "OB"


