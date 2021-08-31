load "../turbo.pal"
set terminal cairolatex standalone pdf size 5in,3in
set output "lambda-comp.tex"
set logscale xy
set format xy '$10^{%L}$'
set xrange [1e4:1e9]
set yrange [1e-23:1e-19]
set key top left
set ytics nomirror
set xlabel 'T(K)'
set ylabel '$\Lambda(\rho,a,T)$'
#set y2tics nomirror
#set logscale y2
#set format y2 '$10^{%L}$'
#set y2label "Error"
#set y2range [1e-5:1e-1]
plot "cooling_comp.txt" u (10**$1):2 t "Integration" w l ls 1,\
"" u (10**$1):3 t "Estimation" w l ls 2#,\
#"" u (10**$1):4 t "Error" w l axes x1y2
