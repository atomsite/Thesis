# Plot a series of normalised plasma and dust cooling curves, calculating the cooling rate 
load "../turbo.pal"
set terminal cairolatex standalone size 5in,3in
set output "coll-el-comp-noratio.tex"

set logscale xy
set format xy '$10^{%L}$'
set ylabel 'dE/dt (erg s$^{-1}$)'
set xlabel 'T (K)'
set xrange[1e4:1e9]


set style fill transparent solid 0.5 noborder
set key bottom right

set datafile separator ","
plot "dust_elec_ion_contribution.csv" u 1:2 t "$H_{coll,WC}$" w l ls 1 dashtype '-' ,\
     "dust_elec_ion_contribution.csv" u 1:3 t "$H_{el,WC}$"  w l ls 1 dashtype '-.' ,\
     "dust_elec_ion_contribution.csv" u 1:($2+$3) t "$H_{tot,WC}$" w l ls 1 ,\
     "dust_elec_ion_contribution.csv" u 1:4 t "$H_{coll,OB}$" w l ls 2 dashtype '-',\
     "dust_elec_ion_contribution.csv" u 1:5 t "$H_{el,OB}$" w l ls 2 dashtype '-.',\
     "dust_elec_ion_contribution.csv" u 1:($4+$5) t "$H_{tot,OB}$" w l ls 2 ,\



