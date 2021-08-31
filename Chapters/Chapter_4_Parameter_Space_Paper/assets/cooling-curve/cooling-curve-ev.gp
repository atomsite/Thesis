load "../turbo.pal"
set terminal cairolatex standalone size 5in,3in
set output "cooling-curve-solar-withev.tex"

set logscale xy
set logscale x2x




set format xy '$10^{%L}$'
set format x2 '$10^{%L}$'

set xtics nomirror
set x2tics

set ylabel '$\Lambda$(T) (erg cm$^3$ s$^{-1}$)'
set xlabel 'T (K)'
set x2label 'E (eV)'

set xrange[1e4:1e9]
set yrange [1e-26:3e-20]

set key top right

set style fill transparent solid 0.5 noborder
set object 1 rect from 1e4,1e-26 to 1e5,1e-18 fc rgb "light-cyan" fillstyle transparent solid 0.25 noborder
set object 2 rect from 1e5,1e-26 to 1e8,1e-18 fc rgb "goldenrod" fillstyle transparent solid 0.25 noborder
set object 3 rect from 1e8,1e-26 to 1e9,1e-18 fc rgb "light-green" fillstyle transparent solid 0.25 noborder

set label 1 "Forbidden\nLines" at 6e4,1.5e-26 left rotate by 90
set label 2 "Resonance\nLines" at 6e7,1.5e-26 left rotate by 90
set label 3 "Bremsstrahlung" at 8e8,1.5e-26 left rotate by 90


k = 1.38064852e-23 # Boltzman constant
e = 1.60217662e-19 # Electron charge
ev(T) = (k*(10**T))/e

plot "cooling_curve_solar" u (10**$1):2 t "Solar" w l ls 1,\
     "cooling_curve_WC"    u (10**$1):2 t "WC"    w l ls 2,\
     "cooling_curve_solar" u (ev($1)):2 notitle w l ls 1 axis x2y1
     

