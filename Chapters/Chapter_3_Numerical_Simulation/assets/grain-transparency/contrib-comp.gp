load "../turbo.pal"
set terminal cairolatex standalone size 5in,3in
set output "contrib-comp.tex"
set datafile separator ','
set colorsequence podo


set logscale xy
set format xy '$10^{%L}$'
set key bottom left
set xlabel 'T(K)'
set ylabel '$H_{el}/H_{coll}$'
set xrange [1e6:1e9]

set grid x y mx my

plot "dc_a0005.dat" u 1:($7/$8) w l t "$5\\times 10^{-3} \\, \\mu$m" ls 1 ,\
     "dc_a0010.dat" u 1:($7/$8) w l t "$1\\times 10^{-2} \\, \\mu$m" ls 2,\
     "dc_a0050.dat" u 1:($7/$8) w l t "$5\\times 10^{-2} \\, \\mu$m" ls 3,\
     "dc_a0100.dat" u 1:($7/$8) w l t "$1\\times 10^{-1} \\, \\mu$m" ls 4,\
     "dc_a0500.dat" u 1:($7/$8) w l t "$5\\times 10^{-1} \\, \\mu$m" ls 5,\
     "dc_a0005.dat" u 1:($4/$8) notitle w l ls 1 dashtype "-",\
     "dc_a0010.dat" u 1:($4/$8) notitle w l ls 2 dashtype "-",\
     "dc_a0050.dat" u 1:($4/$8) notitle w l ls 3 dashtype "-",\
     "dc_a0100.dat" u 1:($4/$8) notitle w l ls 4 dashtype "-",\
     "dc_a0500.dat" u 1:($4/$8) notitle w l ls 5 dashtype "-",\
