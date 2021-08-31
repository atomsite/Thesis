load "../turbo.pal"
set terminal cairolatex size 6in,3in crop standalone
set output "orbits.tex"

au = 1.4959787e+13
set size ratio -1
set xrange [-10:20]
set yrange [-5:5]
set grid
set xlabel 'X (AU)'
set ylabel 'Y (AU)'

set linetype 11 lc rgb 'black' 
set linetype 12 lc rgb 'black' dt 2
set linetype 13 lc rgb 'red' 
set linetype 14 lc rgb 'red' dt 2
set linetype 15 lc rgb 'blue' 
set linetype 16 lc rgb 'blue' dt 2

set key top left

set datafile separator ','
plot "< echo '0 0'" title "Barycenter" lw 4 lt 2 lc rgb "black" , \
     "wr98a.csv" using ($3/au):($4/au) title "WR 98a" with lines ls 1 , \
     "" using ($5/au):($6/au) notitle with lines ls 2 dashtype "-" , \
     "wr104.csv" using ($3/au):($4/au) title "WR 104" with lines ls 2 , \
     "" using ($5/au):($6/au) notitle with lines ls 2 dashtype "-" , \
     "wr140.csv" using ($3/au):($4/au) title "WR 140" with lines ls 3 , \
     "" using ($5/au):($6/au) notitle with lines ls 3 dashtype "-" , \
 
