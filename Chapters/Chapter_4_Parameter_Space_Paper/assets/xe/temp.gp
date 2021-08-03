set terminal cairolatex standalone pdf mono
set output "temp.tex"

set grid
set key bottom left
set ylabel '$h(a,T)$'
set ytics 0.2 nomirror
set logscale x
set format x '$10^{%L}$'
set xrange [1e4:1e9]
set xlabel 'T (K)'
plot "electron-transparency-temp.txt" u 1:2 t "Integration" w l ,\
"" u 1:3 t "Approximation" w l