set terminal cairolatex standalone size 3in,3in mono
set output "piece.tex"

set size square

set xrange [-0.25:6.25]
set yrange [0:3.25]

set xtics 1
set ytics 1

set xlabel "$x$"
set ylabel "$\\mathbf{U}(x)$

unset key

plot "riem.dat" u 1:2 w l ls 1 ,\
     "line.dat" u 1:2 w l ls 2