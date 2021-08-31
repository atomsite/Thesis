load "../turbo.pal"
set terminal cairolatex standalone size 5in,4in
set output "coll-el-comp.tex"

# Slightly jank manual editing of margins so plot looks nice
set multiplot layout 2,1 margins 0.15,0.97,0.11,0.95 spacing 0,0

set logscale xy
set format xy '$10^{%L}$'
set ylabel 'dE/dt (erg s$^{-1}$)'
unset format x

set xlabel ""
set format x ""
set xrange[1e4:1e9]


set style fill transparent solid 0.5 noborder
set key bottom right

set datafile separator ","
plot "dust_elec_ion_contribution.csv" u 1:3 t "$H_{el,WC}$" w l ls 1 dashtype '-' ,\
     "dust_elec_ion_contribution.csv" u 1:2 t "$H_{coll,WC}$"  w l ls 1 dashtype '-.' ,\
     "dust_elec_ion_contribution.csv" u 1:($2+$3) t "$H_{tot,WC}$" w l ls 1 ,\
     "dust_elec_ion_contribution.csv" u 1:5 t "$H_{el,OB}$" w l ls 2 dashtype '-',\
     "dust_elec_ion_contribution.csv" u 1:4 t "$H_{coll,OB}$" w l ls 2 dashtype '-.',\
     "dust_elec_ion_contribution.csv" u 1:($4+$5) t "$H_{tot,OB}$" w l ls 2 ,\

# Manage x axis at bottom, shared with first plot
set format x '$10^{%L}$'
set xlabel 'T (K)'
set xtics

set ylabel '$H_{el}/H_{coll}$'
set format y '  $10^{%L}$'

set yrange [1e0:2e3]

plot "dust_elec_ion_contribution.csv" u 1:($3/$2) t "WC" w l ls 1 ,\
     "dust_elec_ion_contribution.csv" u 1:($5/$4) t "OB"  w l ls 2,\

