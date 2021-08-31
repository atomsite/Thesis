load "../turbo.pal"
set terminal cairolatex standalone size 5in,3in
set output "cooling-curve.tex"

set logscale xy
set format xy '$10^{%L}$'
set ylabel '$\Lambda$(T) (erg cm$^3$ s$^{-1}$)'
set xlabel 'T (K)'
set xrange[1e4:1e9]
set yrange [1e-26:1e-17]

set style fill transparent solid 0.5 noborder
set colorsequence podo
set key bottom right

plot "cooling_curve_WC" u (10**$1):2 t "WC" w l ls 1,\
     "cooling_curve_solar" u (10**$1):2 t "Solar" w l ls 2,\
     "coolcurve_0.005-100keV_H" u (10**$1):2 t "H" ls 3 dashtype '-' w l ,\
     "coolcurve_0.005-100keV_He" u (10**$1):2 t "He" ls 4dashtype '-'w l ,\
     "coolcurve_0.005-100keV_C" u (10**$1):2 t "C" ls 5 dashtype '-' w l ,\
     "coolcurve_0.005-100keV_N" u (10**$1):2 t "N" ls 6 dashtype '-' w l ,\
     "coolcurve_0.005-100keV_O" u (10**$1):2 t "O" ls 7 dashtype '-' w l ,\
     

