load "../turbo.pal"
set terminal cairolatex standalone pdf size 5in,3in
set output "zvaryai.tex"

sectoyr=3.1688765e-08
gtomsol=5.0291442e-34

set logscale y
set format y '10^{%L}'

set datafile separator ','

set xrange [0:1]

set key bottom right

set ylabel '$\bar z$'
set xlabel 't (yr)'
plot "wr98a_Z1E-6_A1E+0.hst" u ($1*sectoyr):($12/$3) t "$a_i=1 \\mu$m" w l ls 1,\
     "wr98a_Z1E-6_A1E-1.hst" u ($1*sectoyr):($12/$3) t "$a_i=0.1 \\mu$m" w l ls 2,\
     "wr98a_Z1E-6_A1E-2.hst" u ($1*sectoyr):($12/$3) t "$a_i=0.01 \\mu$m" w l ls 3
