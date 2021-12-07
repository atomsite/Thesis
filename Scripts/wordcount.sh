# Variables
thesis_directory="$HOME/Documents/Thesis"
# Move to working directory
cd $thesis_directory
# First, decompress .csv
gunzip wordcount.csv.gz
# Get 
datetime=`date -u +"%Y-%m-%d %H:%M:%S"`
pagecount=`pdfinfo Thesis.pdf | grep Pages | sed 's/[^0-9]*//'`
wordcount=`texcount -brief */*/*.tex | tail -n 1 | awk -F '+' '{print $1}'`
# Write info to file
echo "$datetime , $pagecount , $wordcount" >> wordcount.csv
# Render pdf
gnuplot Scripts/plot_wordcount.gp
pdflatex word_count.tex
convert -density 600 -flatten word_count.pdf word_count.png
# Zip up data
gzip -9 wordcount.csv
# Cleanup
rm word_count.tex
rm word_count-inc.pdf
rm word_count.aux
rm word_count.log
