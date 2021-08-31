load "../turbo.pal"
set terminal cairolatex size 5in,3in standalone
set output "orbits-transform.tex"

au = 1.4959787e+13
set size ratio -1
set xrange [-5:35]
set yrange [-10:10]
set grid
set xlabel 'X (AU)'
set ylabel 'Y (AU)'

dsep(x,y) = sqrt(x*x + y*y)
chi(x,y,mdot,vinf) = (((vinf/1e8)**4.0) * (dsep(x,y)/1e12)) / (mdot / 1e-7)

set datafile separator ','
plot "< echo '0 0'" lt 2 lw 4 lc rgb "black" title "OB Partner" , \
     "wr98a.csv" using (($3-$5)/au):(($4-$6)/au) title "WR 98a" w l ls 1, \
     "wr104.csv" using (($3-$5)/au):(($4-$6)/au) title "WR 104" w l ls 2, \
     "wr140.csv" using (($3-$5)/au):(($4-$6)/au) title "WR 140" w l ls 3, \
 
