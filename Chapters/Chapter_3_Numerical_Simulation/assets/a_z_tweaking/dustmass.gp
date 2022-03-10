load "../turbo.pal"
set terminal cairolatex mono size 15cm,20cm crop standalone
set output 'dustmass.tex'

sectoyr=3.1688765e-08
gtomsol=5.0291442e-34
set datafile separator ','

set xlabel "t (Yr)"
set ylabel "Mdot (Msol)"


set multiplot layout 3,1

set grid x y mx my

set ytics 2e-9
set yrange [0.0:1e-8]
set xrange [0:1]

set key top right

set ylabel "$M_d$ (M$_\\odot$)"
set xlabel "t (Yr)"

set title "$a_i = 1 \\times 10^{-1} \\mu \\text m$"
plot "wr98a_Z1E-4_A1E-1.hst" u ($1*sectoyr):($27*gtomsol) t "$z_i=10^{-4}$" w l ls 1 ,\
"wr98a_Z1E-5_A1E-1.hst" u ($1*sectoyr):($27*gtomsol) t "$z_i=10^{-5}$" w l ls 2 ,\
"wr98a_Z1E-6_A1E-1.hst" u ($1*sectoyr):($27*gtomsol) t "$z_i=10^{-6}$" w l ls 3

set title "$a_i = 2 \\times 10^{-2} \\mu \\text m$"
plot "wr98a_Z1E-4_A2E-2.hst" u ($1*sectoyr):($27*gtomsol) t "$z_i=10^{-4}$" w l ls 1,\
"wr98a_Z1E-5_A2E-2.hst" u ($1*sectoyr):($27*gtomsol) t "$z_i=10^{-5}$" w l ls 2 ,\
"wr98a_Z1E-6_A2E-2.hst" u ($1*sectoyr):($27*gtomsol) t "$z_i=10^{-6}$" w l ls 3

set title "$a_i = 1 \\times 10^{-2} \\mu \\text m$"
plot "wr98a_Z1E-4_A1E-2.hst" u ($1*sectoyr):($27*gtomsol) t "$z_i=10^{-4}$" w l ls 1 ,\
"wr98a_Z1E-5_A1E-2.hst" u ($1*sectoyr):($27*gtomsol) t "$z_i=10^{-5}$" w l ls 2 ,\
"wr98a_Z1E-6_A1E-2.hst" u ($1*sectoyr):($27*gtomsol) t "$z_i=10^{-6}$" w l ls 3
