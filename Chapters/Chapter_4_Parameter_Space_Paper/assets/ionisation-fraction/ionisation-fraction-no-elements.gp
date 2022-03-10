load "../turbo.pal"
set terminal cairolatex standalone size 5in,3in
set output "ionisation-fraction-no-elements.tex"

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
     "electron_solar" u (10**$1):2 t "Solar" w l ls 2
     
