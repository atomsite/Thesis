set terminal cairolatex standalone size 3in,3in
set output "riemann.tex"
load "../turbo.pal"

set size square

set xrange [-1.25:1.25]
set yrange [-1.25:1.25]

set xtics 1
set ytics 1

set xlabel "$x$"
set ylabel "$\\mathbf{U}(x)$

unset key

plot "riemann.dat" u 1:2 w l ls 1 