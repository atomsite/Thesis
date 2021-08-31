load "../turbo.pal"
set terminal cairolatex size 5in,3in crop standalone
set output "chi-vs-phase.tex"

#set size ratio -1
#set xrange [-5:35]
#set yrange [-10:10]
set grid
set xlabel 'Phase'
set ylabel '$\chi$'

set format y '$10^{%L}$'


set logscale y

chi(sep,mdot,vinf) = (((vinf/1e8)**4.0) * (sep/1e12)) / (mdot / 1e-7)

set datafile separator ','
plot "wr98a.csv" using ($1/48038400):(chi($7,5.0e-6,0.9e8))  title "WR 98a" w l ls 1, \
     "wr98a.csv" using ($1/48038400):(chi($7,5.0e-8,2.0e8))  notitle w l ls 1 dashtype "-",\
     "wr104.csv" using ($1/21168000):(chi($7,3.0e-5,1.22e8)) title "WR 104" w l ls 2, \
     "wr104.csv" using ($1/21168000):(chi($7,6.0e-8,2.0e8))  notitle w l ls 2 dashtype "-", \
     "wr140.csv" using ($1/2.478816e+08):(chi($7,5.7e-5,2.86e8)) title "WR 140" w l ls 3 ,\
     "wr140.csv" using ($1/2.478816e+08):(chi($7,1.6e-6,3.20e8)) notitle w l ls 3 dashtype "-",\
