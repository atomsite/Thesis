set terminal cairolatex standalone size 5in,3in
set output "amdahl.tex"
load "../turbo.pal"

set logscale xy
set grid x y mx my
set format x "$10^{%L}$"
set xrange[1:100000]

set xlabel "Cores"
set ylabel "Speedup"

f(p,s)=1.0/(1.0-p+(p/s))
plot f(0.50,x) w l ls 1 t "$p=50\\%$" ,\
     f(0.75,x) w l ls 2 t "$p=75\\%$" ,\
     f(0.90,x) w l ls 3 t "$p=90\\%$" ,\
     f(0.95,x) w l ls 4 t "$p=95\\%$",\
     f(0.99,x) w l ls 5 t "$p=99\\%$"
