set terminal cairolatex standalone size 5in,3in
set output "amdahl.tex"
load "../turbo.pal"

set datafile separator ","

set logscale x
set xrange[1:1e5]
set key bottom right

set logscale x
set grid x y mx my
set format x "$10^{%L}$"

set xlabel "Cores"
set ylabel "Speedup"

st=1135.876
p=0.98657006

f(p,s)=1.0/(1.0-p+(p/s))
plot "bench-first22.csv" every :::::9 u 9:(st/$2) ls 1 t "Data",\
  f(p,x) w l ls 2 t "$p=98.7\\%$"