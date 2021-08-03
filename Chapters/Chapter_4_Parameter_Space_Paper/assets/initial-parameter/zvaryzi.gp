set terminal cairolatex standalone pdf mono size 12cm,8cm
set output "zvaryzi.tex"

sectoyr=3.1688765e-08
gtomsol=5.0291442e-34

set logscale y
set format y '10^{%L}'

set datafile separator ','

set xrange [0:1]

set ylabel '$\bar z$'
set xlabel 't (Yr)'
plot "wr98a_Z1E-4_A1E-2.hst" u ($1*sectoyr):($12/$3) t "$z_i=10^{-4}$" w l ,\
     "wr98a_Z1E-5_A1E-2.hst" u ($1*sectoyr):($12/$3) t "$z_i=10^{-5}$" w l ,\
     "wr98a_Z1E-6_A1E-2.hst" u ($1*sectoyr):($12/$3) t "$z_i=10^{-6}$" w l
