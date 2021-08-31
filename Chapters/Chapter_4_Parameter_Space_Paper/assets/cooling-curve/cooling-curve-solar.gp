load "../turbo.pal"
set terminal cairolatex standalone mono size 5in,3in
set output "cooling-curve-solar.tex"

set logscale xy
set format xy '$10^{%L}$'
set ylabel '$\Lambda$(T) (erg cm$^3$ s$^{-1}$)'
set xlabel 'T (K)'
set xrange[1e4:1e9]
set yrange [1e-26:1e-21]

set style fill transparent solid 0.5 noborder
set key bottom right

plot "cooling_curve_solar" u (10**$1):2 notitle w l ls 1,\
     
