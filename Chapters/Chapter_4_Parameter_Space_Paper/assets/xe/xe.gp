

set terminal cairolatex standalone pdf mono
set output "xe.tex"
set grid
set key bottom
set ylabel '$h(a,T)$'
set ytics 0.2
set xlabel "$x^*$"
set xrange [0:15]
# set y2tics nomirror
set logscale y2
set format y2 '$10^{%L}$'
# set y2label "Error"
# set y2range [1e-5:1e-1]

set yrange [0:1.1]
plot "electron-transparency-xe.txt" u 1:2 t "Integration" w l ,\
"" u 1:3 t "Approximation" w l # ,\
#"" u 1:(abs(($2-$3)/$2)) t "Error" w l axes x1y2
