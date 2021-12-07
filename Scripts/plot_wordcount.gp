set terminal cairolatex standalone size 5in,2in
set output "word_count.tex"
load "Scripts/gp-pal.pal"

set y2tics nomirror
set ytics nomirror

set xdata time
set timefmt "%m/%d/%y"

set xrange ["12/01/21":"05/01/22"]
set yrange [0:200]
set y2range [0:30000]

set format x "%b"

set xlabel "Date"
set ylabel "Pages"
set y2label "Words"

# Begin plotting
set timefmt "%Y-%m-%d %H:%M:%S"
set datafile separator ","
plot "wordcount.csv" using 1:2 title "Pages" w l ls 1 ,\
     "" using 1:3 title "Words" w l ls 2 axes x1y2
