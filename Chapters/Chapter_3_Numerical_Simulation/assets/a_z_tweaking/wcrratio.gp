load "../turbo.pal"
set terminal cairolatex standalone size 5in,3in
set output 'wcrratio.tex'
sectoyr=3.1688765e-08
gtomsol=5.0291442e-34
set datafile separator ','
# set multiplot layout 3,1
set xrange [0:1]
set ytics 0.2
set grid mx my x y

set key bottom right 

set ylabel "M_{d,WCR}/M_{d,tot}"
set xlabel "t (yr)"

plot "wr98a_Z1E-4_A1E-2.hst" u ($1*sectoyr):($27/$28) t "$z_i=10^{-4}$" w l ls 1,\
"wr98a_Z1E-5_A1E-2.hst" u ($1*sectoyr):($27/$28) t "$z_i=10^{-5}$" w l ls 2,\
"wr98a_Z1E-6_A1E-2.hst" u ($1*sectoyr):($27/$28) t "$z_i=10^{-6}$" w l ls 3
