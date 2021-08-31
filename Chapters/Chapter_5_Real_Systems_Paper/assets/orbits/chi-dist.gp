load "../turbo.pal"
set terminal cairolatex size 5in,3in crop standalone
set output "chi-vs-dist.tex"

#set size ratio -1
#set xrange [-5:35]
#set yrange [-10:10]
set grid
set xlabel '$d_{sep}$ (AU)'
set ylabel '$\chi$'

set format y '$10^{%L}$'

cmtoau=6.6845871e-14

set logscale y

chi(sep,mdot,vinf) = (((vinf/1e8)**4.0) * (sep/1e12)) / (mdot / 1e-7)

set datafile separator ','
plot "wr140.csv" using ($7*cmtoau):(chi($7,5.7e-5,2.86e8)) title "WC" w l ls 1 ,\
     "wr140.csv" using ($7*cmtoau):(chi($7,1.6e-6,3.20e8)) title "OB" w l ls 2 ,\
