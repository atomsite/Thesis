load "../turbo.pal"
set terminal cairolatex standalone size 5in,4in
set output "lambda-dust-speedup.tex"
set datafile separator ','

set key top left
set xrange [1:10000]
set logscale x

# Slightly jank manual editing of margins so plot looks nice
set multiplot layout 2,1 margins 0.15,0.97,0.11,0.95 spacing 0,0

# Plot first plot, which shows exection time in seconds

# Blank x axis, as shared with second plot
set format x ""
set xlabel ""

# Manage y axis
set ylabel "Execution time (s)"
set logscale y
set format y '$10^{%L}$'

set grid x y mx my

plot "comparison.csv" using 1:3 t "   Calculation" w l ls 1, \
   "" using 1:4 t "   Search+TL" w l ls 2, \
   "" using 1:5 t "   Index+BL+L" w l ls 3
   
# Plot second plot, which shows the speedup, ts/t

# Remove key, as at top and common
unset key

# Manage x axis at bottom, shared with first plot
set format x '$10^{%L}$'
set xlabel 'Number of Cooling Steps'

# Manage y axis
unset logscale y
set yrange [0:22]
set ytics 5
set format y '  %.0f'
set ylabel 'Speedup'
   
plot "comparison.csv" using 1:(($3/$3)) w l ls 1,\
   "" using 1:(($3/$4)) w l ls 2, \
   "" using 1:($3/$5) w l ls 3

