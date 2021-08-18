set terminal cairolatex standalone mono size 5in,3in
set output "cooling-curve-no-elements.tex"

set logscale xy
set format xy '$10^{%L}$'
set grid
set ylabel '$\Lambda$(T) (erg cm$^3$ s$^{-1}$)'
set xlabel 'T(K)'
set xrange[1e4:1e9]
set yrange [1e-26:1e-19]

set style fill transparent solid 0.5 noborder
set colorsequence podo
set key bottom right

plot "cooling_curve_WC" u (10**$1):2 t "WC" w l ,\
     "cooling_curve_solar" u (10**$1):2 t "Solar" w l ,\
     
