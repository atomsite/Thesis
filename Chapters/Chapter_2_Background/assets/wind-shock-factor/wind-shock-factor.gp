load "../turbo.pal"
set terminal cairolatex standalone size 6in,2in
set output "shock-factor.tex"

set format x  '$10^{%L}$'
set format y  '${%.0f}$'
set format y2 '${%.1f}$'

set xlabel  "$\\eta$"
set ylabel  "$\\theta (\\eta)$"
set y2label "$f (\\eta)$"

set ytics nomirror
set y2tics

set grid xtics mxtics

set logscale x

set xrange [1e-3:1]
set yrange [0:120]
set y2range [0:1]

set key outside

theta1(eta) = 2 * atan(eta**(0.33333)) + (3.14159/9.0)
theta2(eta) = 0.658 * log10(71.7 * eta)

f1(eta) = (1 - cos(theta1(eta))) / 2
f2(eta) = (1 + cos(theta2(eta))) / 2

plot theta1(x)*57.2958 w l ls 1 t "$\\theta_1 (\\eta)$" ,\
     [0.014:1] theta2(x)*57.2958 w l ls 2 t "$\\theta_2 (\\eta)$" ,\
     f1(x) w l ls 1 dashtype "--" axes x1y2 t "$f_1 (\\eta)$" ,\
     [0.014:1] f2(x) w l ls 2 dashtype "--" axes x1y2 t "$f_2 (\\eta)$"