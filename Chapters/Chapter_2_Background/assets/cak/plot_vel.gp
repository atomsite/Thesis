# Set terminals and outputs
set terminal cairolatex standalone size 6in,3in
set output "vel.tex"

load "../turbo.pal"

set logscale x
set logscale y

set format x '$10^{%L}$'
set format y '$10^{%L}$'

set xrange [1e-4:1e3]

set xlabel "$(R/R_*)-1$"
set ylabel "$v_w$ (km s$^{-1}$)"

rratio(r,rs)=(r/rs)-1

set multiplot layout 1,2

set grid xtics ytics mxtics mytics

set key bottom right

plot 'velocity_wr140_ob.cak' using (rratio($1,12.0)):($2/1e5) w l ls 1 title 'WR140 O5' ,\
     'velocity_wr140_wc.cak' using (rratio($1,4.0)):($2/1e5) w l ls 2 title 'WR140 WC7'

set ylabel "$\\rho_w$ (g cm$^{-3}$)"
set key top right 

plot 'density_wr140_ob.cak' using (rratio($1,12.0)):($2/1e5) w l ls 1 title 'WR140 O5' ,\
     'density_wr140_wc.cak' using (rratio($1,4.0)):($2/1e5) w l ls 2 title 'WR140 WC7'
