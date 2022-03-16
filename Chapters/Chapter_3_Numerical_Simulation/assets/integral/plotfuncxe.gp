set terminal cairolatex standalone size 5in,3in
set output "func_xe_plot.tex"

load "turbo.pal"

set grid x y mx my 

set samples 1000

set format x  '$10^{%L}$'


set xlabel "$z$"
set ylabel "$\\mathcal{K}(x^*,z)$"

f(xe,z)=(z+xe)*(((xe + z)**1.5) - (xe**1.5))**(0.666) * exp(-z)

set logscale x
set xrange [1e-3:1e2]

set ytics 0.1

# splot f(x,y) w l 

plot f(0.001,x) w l ls 1 t "$x^* = 0.001$",\
     f(0.01,x) w l ls 2 t "$x^* = 0.010$",\
     f(0.10,x) w l ls 3 t "$x^* = 0.100$",\
     f(1.00,x) w l ls 4 t "$x^* = 1.000$"
