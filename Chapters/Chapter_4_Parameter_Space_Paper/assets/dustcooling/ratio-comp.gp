set terminal cairolatex standalone pdf mono
set output "ratio-comp.tex"
set logscale xy
set logscale y2
set format xy '$10^{%L}$'
set format y2 '$10^{%L}$'
set xrange [1e4:1e9]
set ytics nomirror
set y2tics nomirror
set xlabel 'T (K)'
set ylabel '$H_{\text{el}}/H_{\text{coll}}$'
set y2label 'Error'
set y2range [1e-5:1e-1]
set grid
set key bottom
plot "contrib_comp.txt" u ($1):($5/$4) t "Integration" w l ,\
"" u ($1):($3/$2) t "Approximation" w l ,\
"" u ($1):(abs((($3/$2)-($5/$4))/($5/$4))) t "Error" w l axes x1y2