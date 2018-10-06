# Baby names problem
Let's make a script that extracts the number of babies born with a specified name each year and plot it.

## Get the data
```
wget https://raw.githubusercontent.com/hadley/data-baby-names/master/baby-names.csv
```

## Practice with grep
```
grep Alex\" baby-names.csv | grep boy
```

## Practice plotting with Gnuplot
Do not forget to enalbe graphics forwarding if needed.
```
grep Alex\" baby-names.csv | grep boy > data.csv
gnuplot
set datafile separator ","
plot "data.csv" u 1:3 with points
```

## Let's make a script for Gnuplot
```
echo 'set datafile separator ","' > plot.plt
echo 'plot "data.csv" u 1:3 with points' >> plot.plt
echo 'pause -1' >> plot.plt
gnuplot plot.plt
```

## Let's make a bash script that looks like this
Script name should be script.sh
```
#!/bin/bash
grep $1\" baby-names.csv | grep boy > data.csv
gnuplot plot.plt
```

## Ultimate automation
```
chmod u+x script.sh
./script.sh Alex
```
