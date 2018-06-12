#!/bin/bash
# ----------------------------------------------- #
# Config
# ----------------------------------------------- #
config='config.txt'


# ----------------------------------------------- #
# Assignment of variables
# ----------------------------------------------- #
spreadsheet=$(sed '10q;d' $config)
spreadsheet=${spreadsheet#*= }
csv_file=$(sed '11q;d' $config)
csv_file=${csv_file#*= }
cwd=$(pwd)"/files/"
folder=$(find $cwd -name '*.pdf')
output=$(sed '12q;d' $config)
output=${output#*= }


# ----------------------------------------------- #
# Convert xlsx to usable csv
# ----------------------------------------------- #
xlsx2csv $spreadsheet $csv_file


# ----------------------------------------------- #
# Retrieve name(s) from a folder of pdf file(s)
# ----------------------------------------------- #
for file in $folder
do
	name=$(pdfgrep "Name student" $file)
	echo ${name:15:-25} >> unformatted_names.txt
done

# ----------------------------------------------- #
# Format name to 'lastname,firstname'
# ----------------------------------------------- #
while read person; do
	f_n=${person/${person#* }};
	l_n=${person#* };
	echo $l_n,$f_n >> formatted_names.txt
done <unformatted_names.txt


# ----------------------------------------------- #
# Retrieve email using flipped names
# ----------------------------------------------- #
while read person; do
	echo $(cat $csv_file | grep "$person") >> emails_unformatted.txt
done <formatted_names.txt


# ----------------------------------------------- #
# Strips unnessesary information
# ----------------------------------------------- #
while read row; do
	## Strip student number from #*start -> comma
	no_sn=${row#*,};
	## Strip last name from #*start -> comma
	no_ln=${no_sn#*,};
	## Strip first name from #*start -> comma
	no_fn=${no_ln#*,};
	echo $no_fn >> unverified_results.txt
done <emails_unformatted.txt

while read person; do
	val1=${person% *};
	val2=${val1% *};
	val3=${val2% *};
	val4=${val3% *};
	val5=${val4% *};
	val6=${val5% *};
	val7=${val6% *};
	val8=${val7% *};
	val9=${val8% *};
	val10=${val9% *};
	content="$content; $val10"
done < unverified_results.txt
content=$(echo $content | cut -c 2-)
echo $content >> $output


# ----------------------------------------------- #
# Cleanup
# ----------------------------------------------- #
rm $csv_file
rm unformatted_names.txt
rm emails_unformatted.txt
rm formatted_names.txt
rm unverified_results.txt


# ----------------------------------------------- #
# Print result to terminal
# ----------------------------------------------- #
# cat $output


