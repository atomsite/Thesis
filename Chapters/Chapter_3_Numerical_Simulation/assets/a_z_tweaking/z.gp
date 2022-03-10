load "../turbo.pal"
set terminal cairolatex size 5in,7in crop standalone
set output 'z.tex'

sectoyr=3.1688765e-08
gtomsol=5.0291442e-34

set multiplot layout 3,1

set datafile separator ','

set grid x y mx my 
set xrange [0:1]
set yrange [1e-6:1.5e-2]
set key bottom right

set logscale y
set format y ' $10^{%L}$'

set xlabel "t (yr)"
set ylabel "$z$"

set title "$z_i = 10^{-4}$"
plot "wr98a_Z1E-4_A1E+0.hst" u ($1*sectoyr):($12/$3) t "$a_i$ = 1.00 $\\mu$m" w l ls 1,\
"wr98a_Z1E-4_A1E-1.hst" u ($1*sectoyr):($12/$3) t "$a_i$ = 0.10 $\\mu$m" w l ls 2,\
"wr98a_Z1E-4_A2E-2.hst" u ($1*sectoyr):($12/$3) t "$a_i$ = 0.02 $\\mu$m" w l ls 3,\
"wr98a_Z1E-4_A1E-2.hst" u ($1*sectoyr):($12/$3) t "$a_i$ = 0.01 $\\mu$m" w l ls 4


set title "$z_i = 10^{-5}$"
plot "wr98a_Z1E-5_A1E+0.hst" u ($1*sectoyr):($12/$3) t "$a_i$ = 1.00 $\\mu$m" w l ls 1,\
"wr98a_Z1E-5_A1E-1.hst" u ($1*sectoyr):($12/$3) t "$a_i$ = 0.10 $\\mu$m" w l ls 2,\
"wr98a_Z1E-5_A2E-2.hst" u ($1*sectoyr):($12/$3) t "$a_i$ = 0.02 $\\mu$m" w l ls 3,\
"wr98a_Z1E-5_A1E-2.hst" u ($1*sectoyr):($12/$3) t "$a_i$ = 0.01 $\\mu$m" w l ls 4

set title "$z_i = 10^{-6}$"
plot "wr98a_Z1E-6_A1E+0.hst" u ($1*sectoyr):($12/$3) t "$a_i$ = 1.00 $\\mu$m" w l ls 1,\
"wr98a_Z1E-6_A1E-1.hst" u ($1*sectoyr):($12/$3) t "$a_i$ = 0.10 $\\mu$m" w l ls 2,\
"wr98a_Z1E-6_A2E-2.hst" u ($1*sectoyr):($12/$3) t "$a_i$ = 0.02 $\\mu$m" w l ls 3,\
"wr98a_Z1E-6_A1E-2.hst" u ($1*sectoyr):($12/$3) t "$a_i$ = 0.01 $\\mu$m" w l ls 4
