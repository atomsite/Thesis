set terminal cairolatex standalone size 5in,3in
set output "lifespan.tex"
load "../turbo.pal"

set ytics nomirror
set y2tics

#set format x  '$10^{%L}$'
set format y  '$10^{%L}$
set format y2  '$10^{%L}$


set logscale x
set logscale y
set logscale y2

set grid xtics ytics mxtics mytics

set xrange [0.1:300]
set yrange [1e6:1e13]
set y2range [1e-3:1e9]

set ylabel "$\\tau_\\star$ (yr)"
set xlabel "$M_\\star ~ (M_\\odot)$
set y2label "$L_\\star ~ (L_\\odot)$


plot "mist-zams.dat" u 1:2 ls 1 w l t "$\\tau_\\star$" ,\
 "mist-zams.dat" u 1:3 w l ls 2 axes x1y2 t "$L_\\star$" ,\
 (1e10*(x**(-2.5))) w l ls 1 dashtype "--" notitle ,\
 (x**(3.6)) w l ls 2 dashtype "--" axes x1y2 notitle 