# Remake of the magnitudes.pdf file, previously used but incorrect, could not find the original source file

load "../turbo.pal"
set terminal cairolatex size 5in,3in crop standalone
set output 'magnitudes-new.tex'



set datafile separator ","

set xdata time
set timefmt "%Y"
set xrange ["1970":"2002"]
set timefmt "%Y/%m/%d"
set format x "%Y"
set xtics 5

set xtics 1.578e+8

set yrange [17:0.1]

set xlabel "Year"
set ylabel "L$^\\prime$ ($3.8\\,\\mu$m) Magnitudes"

set key bottom left

set grid x y mx my

set pointintervalbox 0.5



plot "WR 140.csv" u 1:2 t "  WR 140" w linespoints ls 1 pt 7 pi -1 ps 0.25 ,\
     "WR 137.csv" u 1:2 t "  WR 137" w linespoints ls 2 pt 7 pi -1 ps 0.25 ,\
     "WR 125.csv" u 1:2 t "  WR 125" w linespoints ls 3 pt 7 pi -1 ps 0.25 ,\
     "WR 19.csv" u 1:2 t "  WR 19" w linespoints ls 4 pt 7 pi -1 ps 0.25 ,\
     "WR 48a.csv" u 1:2 t "  WR 48a" w linespoints ls 5 pt 7 pi -1 ps 0.25 ,\