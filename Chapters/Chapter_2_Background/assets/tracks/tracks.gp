set terminal cairolatex standalone size 5in,3in
set output "tracks.tex"
load "../turbo.pal"

set grid x y mx my

set format x  '$10^{%L}$'
set format y  '$10^{%L}$'

set key bottom right

set xlabel "T (K)"
set ylabel "$L_\\star$ ($L_\\odot$)"

set logscale xy

set xrange [3e5:3e3]
set yrange [1e4:6e6]

plot "20.0-msol-track.dat" u 1:2 w l ls 1 t "O9V - $20 \\, M_\\odot$" ,\
"24.0-msol-track.dat" u 1:2 w l ls 2 t "O8V - $24 \\, M_\\odot$" ,\
"32.0-msol-track.dat" u 1:2 w l ls 3 t "O7V - $32 \\, M_\\odot$" ,\
"45.0-msol-track.dat" u 1:2 w l ls 4 t "O6V - $45 \\, M_\\odot$" ,\
"60.0-msol-track.dat" u 1:2 w l ls 5 t "O5V - $60 \\, M_\\odot$" ,\
"85.0-msol-track.dat" u 1:2 w l ls 6 t "O4V - $85 \\, M_\\odot$" ,\
"120.0-msol-track.dat" u 1:2 w l ls 7 t "O3V - $120 \\, M_\\odot$" ,\

     