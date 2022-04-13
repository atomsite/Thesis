set terminal cairolatex standalone size 5in,3in 
set output "word_count.tex"
load "Scripts/gp-pal.pal"

set y2tics nomirror
set ytics nomirror

set xdata time

set yrange [17:*]
set y2range [0:*]

set format x "%b"

set xlabel "Date"
set ylabel "Pages"
set y2label "Words"

set ytics 25
set y2tics 5000

set grid xtics ytics mxtics mytics

set key top left

# Begin plotting

set timefmt "%m/%d/%y"
set xrange ["07/20/21":"05/04/22"]
set timefmt "%Y-%m-%d %H:%M:%S"

set datafile separator ","
plot "wordcount.csv" using 1:2 title "~Pages" w l ls 1 ,\
     "" using 1:3 title "~Words" w l ls 2 axes x1y2 ,\