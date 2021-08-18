set terminal cairolatex standalone mono size 5in,3in
set output "momentum-ratio.tex"

set grid

set arrow 1 from 0.2,0.0 to 0.4,0.0 lw 2 # 0 degrees

f(rob,xi) = ((rob * xi) / sin(xi))

g(eta) = 2.1 * ( 1 - (eta**(2/5) / 4)) * eta**(-1/3)


plot [0:pi/2] f(1.0,x) w l ,\
     [0:1] g(0.01) w l ,\
     [0:pi/2] f(3.0,x) w l ,\


