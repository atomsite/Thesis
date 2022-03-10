load "../turbo.pal"
set terminal cairolatex standalone size 5in,3in
set output "ionisation-fraction.tex"

set logscale x
set format x '$10^{%L}$'
set ylabel '$n_e / n_T$'
set xlabel 'T (K)'
set xrange[1e4:1e9]
set key bottom right

set style fill transparent solid 0.5 noborder

set key top left

set grid x y mx my

plot "electron_WC" u (10**$1):2 t "WC" w l ls 1,\
     "electron_solar" u (10**$1):2 t "Solar" w l ls 2,\
     "electron_H" u (10**$1):2 t "H" ls 3 dashtype '-' w l ,\
     "electron_He" u (10**$1):2 t "He" ls 4 dashtype '-'w l ,\
     "electron_C" u (10**$1):2 t "C" ls 5 dashtype '-' w l ,\
     "electron_N" u (10**$1):2 t "N" ls 6 dashtype '-' w l ,\
     "electron_O" u (10**$1):2 t "O" ls 7 dashtype '-' w l ,\
     
