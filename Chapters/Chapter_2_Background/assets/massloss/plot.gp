set terminal cairolatex standalone size 5in,3in
set output "massloss.tex"
load "../turbo.pal"

set grid x y mx my

set xlabel "t (Myr)"
set ylabel "$M_\\star ~ (M_\\odot)$"


plot "60.0msol-mass.dat" u ($1/1e6):2 w l ls 1 t "$60 \\, M_\\odot$" ,\
     "80.0msol-mass.dat" u ($1/1e6):2 w l ls 2 t "$80 \\, M_\\odot$" ,\
     "100.0msol-mass.dat" u ($1/1e6):2 w l ls 3 t "$100 \\, M_\\odot$" ,\
     "120.0msol-mass.dat" u ($1/1e6):2 w l ls 4 t "$120 \\, M_\\odot$" ,\
     "140.0msol-mass.dat" u ($1/1e6):2 w l ls 5 t "$140 \\, M_\\odot$"
     