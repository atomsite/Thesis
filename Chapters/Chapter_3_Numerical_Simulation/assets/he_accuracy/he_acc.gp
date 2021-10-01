load "palette.pal"
set terminal cairolatex standalone size 5in,3in
set output "he_acc.tex"

set logscale x
set logscale y
set key bottom left
set format x '$10^{%L}$'
set format y '$10^{%L}$'

set xlabel "T (K)"
set ylabel "$h_e$"

set xrange[1e6:1e9]
set yrange[1e-5:1e0]

set datafile separator ','

plot  "< gzip -dc h_e-1.csv"    u (10**$1):2 every 10 w l ls 1 title "1 bin" ,\
      "< gzip -dc h_e-5.csv"    u (10**$1):2 every 10  w l ls 2 title "5 bins" ,\
      "< gzip -dc h_e-10.csv"   u (10**$1):2 every 10  w l ls 3 title "10 bins" ,\
      "< gzip -dc h_e-25.csv"   u (10**$1):2 every 10  w l ls 4 title "25 bins" ,\
      "< gzip -dc h_e-50.csv"   u (10**$1):2 every 10  w l ls 5 title "50 bins" ,\
      "< gzip -dc h_e-100.csv"  u (10**$1):2 every 10  w l ls 6 title "100 bins" ,\
      "< gzip -dc h_e-250.csv"  u (10**$1):2 every 10  w l ls 7 title "250 bins" ,\
      "< gzip -dc h_e-500.csv"  u (10**$1):2 every 10  w l ls 8 title "500 bins" ,\
      "< gzip -dc h_e-1000.csv" u (10**$1):2 every 10  w l ls 9 title "1000 bins" ,\
      "< gzip -dc h_e-2500.csv" u (10**$1):2 every 10  w l ls 10 title "2500 bins" ,\



