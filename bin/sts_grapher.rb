#!/usr/bin/env ruby
#
#

data = {}
File.open('experiments/AlgorithmTesting/finalAnalysisReport.txt') do |f|
    f.readlines.each do |line|
        if line.chomp.match(/^((\s\d)|\d+)/)
            line.gsub(/^\s/,'')
            data[line.chomp.split(' ')[12]] = line.chomp.split(' ')[0..9]
        end
    end
end

File.open('data.dat', 'w') do |f|
    0.upto(9) do |i|
        data.each do |k, v|
            f.print "#{v[i]}  "
        end
        f.puts
    end
end


template = "set terminal png
set output \"block.png\"
set title \"Block Frequency Test\\nDistribution of P-Values\\n10000 \
bits per block\"
set style data histogram
set style histogram clustered gap 0
set style fill solid border -1
set boxwidth 1 relative
set grid
set ylabel \"Frequency\"
set xlabel \"Interval\"
set xrange [0.0:10.0]
set xtics (\"0\" 0, \"0.1\" 1, \"0.2\" 2, \"0.3\" 3, \"0.4\" 4, \"0.5\" 5, \
    \"0.6\" 6, \"0.7\" 7, \"0.8\" 8, \"0.9\" 9, \"10\" 10)
plot 'plot.dat' using 1 title \"/dev/urandom\""

File.open('plot.gp', 'w') do |f|
    f.puts template
end    
