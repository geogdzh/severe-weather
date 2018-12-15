#!/bin/bash
#data retrieval for Evaluating Severe Weather Prediction...
#sounding data from UWyo's Upper Air database
#will download all records from 1973 to 2017 for all stations in station_list.txt for 12Z
#can be stopped and started, wil re-check for existing files
#creates ./data directory

if ! [ -d ./data ]
then
var1=$(seq -w 1 12)
var2=$(seq -w 1 28)

file="station_list.txt"
while read line
do
    for year in {1973..2017}
    do for month in $var1 
	do for day in $var2
	    do
		if [ -f ./data/${line}_${year}_${month}_${day}.txt ]; then
		    echo ${line}_${year}_${month}_${day}.txt exists!
		else
		    curl weather.uwyo.edu/cgi-bin/sounding\?region\=naconf\&TYPE\=TEXT\%3ALIST\&YEAR\=$year\&MONTH\=$month\&FROM\=${day}12\&T0\=${day}12\&STNM\=$line > temp1.txt
		    sed '/^</ d' temp1.txt > temp2.txt
		    awk -v m=4 -v n=11 'NR<=m{next};NR>n+m{print line[NR%n]};{line[NR%n]=$0}' temp2.txt > ./data/${line}_${year}_${month}_${day}.txt
		    rm temp1.txt temp2.txt
		fi
	    done
	done
    done
    echo Done with $line 28 days
done < $file

echo All done with 28 days

file="station_list.txt"
while read line
do
    for year in {1973..2017}
    do for month in {01,03,04,05,06,07,08,09,10,11,12} 
	do for day in {29..30}
	    do
		if [ -f ./data/${line}_${year}_${month}_${day}.txt ]; then
                    echo it exists!
                else
		    curl weather.uwyo.edu/cgi-bin/sounding\?region\=naconf\&TYPE\=TEXT\%3ALIST\&YEAR\=$year\&MONTH\=$month\&FROM\=${day}12\&T0\=${day}12\&STNM\=$line > temp1.txt
		    sed '/^</ d' temp1.txt > temp2.txt
		    awk -v m=4 -v n=11 'NR<=m{next};NR>n+m{print line[NR%n]};{line[NR%n]=$0}' temp2.txt > ./data/${line}_${year}_${month}_${day}.txt
		    rm temp1.txt temp2.txt
		fi
	    done
	done
    done
    echo done with $line for 30 days
done < $file

echo All done with 30 days

file="station_list.txt"
while read line
do
    for year in {1973..2017}
    do for month in {01,03,05,07,08,10,12} 
	do for day in 31
	    do
		if [ -f ./data/${line}_${year}_${month}_${day}.txt ]; then
                    echo it exists!
                else
		    curl weather.uwyo.edu/cgi-bin/sounding\?region\=naconf\&TYPE\=TEXT\%3ALIST\&YEAR\=$year\&MONTH\=$month\&FROM\=${day}12\&T0\=${day}12\&STNM\=$line > temp1.txt
		    sed '/^</ d' temp1.txt > temp2.txt
		    awk -v m=4 -v n=11 'NR<=m{next};NR>n+m{print line[NR%n]};{line[NR%n]=$0}' temp2.txt > ./data/${line}_${year}_${month}_${day}.txt
		    rm temp1.txt temp2.txt
		fi
	    done
	done
    done
    echo done with $line for 31 days
done < $file

echo All done with 31 days

fi