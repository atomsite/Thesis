load "../turbo.pal"
set terminal cairolatex standalone size 5in,3in
set output "reaction-solar.tex"

set format xy '$10^{%L}$'

set logscale xy
set xrange [2e6:1e9]
set yrange [1e-5:1e10]

set xlabel "T (K)"
set ylabel "$\\epsilon$ (erg s$^{-1}$ g$^{-1}$)"

set grid x y mx

set arrow from 1.5e7,1e-5 to 1.5e7,1e10 nohead ls 4 lc "black" dashtype "-"

set label 1 "\\scriptsize{$T=1.5\\times 10^7$\,K}" at 1.4e7,5e4 left rotate by 90

set key top left

plot "solar.dat" u 1:2 w l ls 1 title "p-p",\
     "solar.dat" u 1:3 w l ls 2 title "CNO",\
     "solar.dat" u 1:4 w l ls 3 title "3$\\alpha$" ,\
     "solar.dat" u 1:5 w l ls 1 dashtype "-" title "Total"
    #  "solar.dat" u 1:4 w l ls 3 title "3$\\alpha$",\