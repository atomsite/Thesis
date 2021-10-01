load "palette.pal"
set terminal cairolatex standalone size 5in,3in
set output "exectime.tex"

set logscale xy
# set key bottom left
set format x '$10^{%L}$'
set format y '$10^{%L}$'

set ylabel "Integration time (ns)"
set xlabel "Bins"

set datafile separator ','

plot  "exectime.csv" u 1:(1e6*$6) w l ls 1 notitle 