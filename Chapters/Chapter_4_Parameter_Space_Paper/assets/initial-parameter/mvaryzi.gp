load "../turbo.pal"
set terminal cairolatex standalone size 5in,3in
set output "mvaryzi.tex"

sectoyr=3.1688765e-08
gtomsol=5.0291442e-34
set datafile separator ','

set ytics 2
set yrange [0.0:10]
set xrange [0:1]

set ylabel '$M_D$ ($10^{-9} M_{\odot}$)'
set xlabel 't (yr)'

plot "wr98a_Z1E-4_A1E-2.hst" u ($1*sectoyr):($27*gtomsol*1e9) t "$Z_i=10^{-4}$" w l ls 1,\
     "wr98a_Z1E-5_A1E-2.hst" u ($1*sectoyr):($27*gtomsol*1e9) t "$Z_i=10^{-5}$" w l ls 2,\
     "wr98a_Z1E-6_A1E-2.hst" u ($1*sectoyr):($27*gtomsol*1e9) t "$Z_i=10^{-6}$" w l ls 3
