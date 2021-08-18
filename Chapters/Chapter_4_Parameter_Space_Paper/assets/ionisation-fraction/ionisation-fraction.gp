set terminal cairolatex standalone size 5in,3in
set output "ionisation-fraction.tex"

set logscale x
set format x '$10^{%L}$'
set grid
set ylabel '$n_e / n_T$'
set xlabel 'T(K)'
set xrange[1e4:1e9]
set key bottom right

set style fill transparent solid 0.5 noborder

set colorsequence podo

set key top left

plot "electron_WC" u (10**$1):2 t "WC" w l ,\
     "electron_solar" u (10**$1):2 t "Solar" w l ,\
     "electron_H" u (10**$1):2 t "H" dashtype '-' w l ,\
     "electron_He" u (10**$1):2 t "He" dashtype '-'w l ,\
     "electron_C" u (10**$1):2 t "C" dashtype '-' w l ,\
     "electron_N" u (10**$1):2 t "N" dashtype '-' w l ,\
     "electron_O" u (10**$1):2 t "O" dashtype '-' w l ,\
     
