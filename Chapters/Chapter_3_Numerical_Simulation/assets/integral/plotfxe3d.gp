set terminal cairolatex standalone size 5in,4in mono
set output "func_xe_3d.tex"
# Figure parameters
set grid x y z mx my mz
set isosamples 40
set hidden3d
set view 45, 45, 1, 1
# Labels and formats
set xlabel "$z$"
set ylabel "$x^\*$"
set zlabel "$\\mathcal{K} (x^*,z)$" rotate by 90
set format x  '$10^{%L}$~~~~~'
# Set ranges and scales of function
set yrange [0:100]
set xrange [1e-4:1e2]
set logscale x
# Plot
f(xe,z)=(z+xe)*(((xe + z)**1.5) - (xe**1.5))**(0.666) * exp(-z)
splot f(y,x) w l notitle
