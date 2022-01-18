

load "../turbo.pal"
set terminal cairolatex standalone size 6in,2in
set output "sputter.tex"

set logscale xy
set format xy '$10^{%L}$'

set xlabel 'T (K)'
set ylabel '$\tau$ (yr $\mu$m cm$^{-3}$)'

set key outside

set yrange [1e4:1e8]

# set grid x y mx my

plot "graphite.dat" u 1:3 w l ls 1 t "Carbon" ,\
     "SiC.dat" u 1:3 w l ls 2 t "SiC" ,\
     "iron.dat" u 1:3 w l ls 3 t "Iron" ,\
     "silicate.dat" u 1:3 w l ls 4 t "Silicates" ,\
     "ice.dat" u 1:3 w l ls 5 t "H$_2$O" ,\
     
