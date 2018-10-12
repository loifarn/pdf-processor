# pdf-processor
This PDF processor was made to automate a menial task where a name had to be reterieved from a PDF document then cross-referenced with a matching name in a spread sheet to retrieve a set of values.

## How it works
1. Converts reference sheet to csv for easier processing using [xlsx2csv](https://github.com/dilshod/xlsx2csv)
2. Scans all PDF documents in subfolder working_directory/files/ for a pre-defined string using [pdfgrep](https://pdfgrep.org/) and stores them in a temporary storage "unformatted\_names.txt"
3. Formats all found occurances stored in "unformatted\_names.txt" to 'lastname,firstname' and saves the result in "formatted_names.txt"
4. Scan & retrieve rows from "any\_spreadsheet.csv" using values from "formatted\_names". Results are stored in "emails\_unformatted.txt"
5. Takes each row from "emails\_unformatted.txt", strips off unwanted information and stores the remainder (an email address in this case) to "emails\_formatted.txt"
6. Cleans up all temporary files

## What it's not
- Remotely universal or applicable to anything else
- Optimized at all
- Using a good configuration structure

## What can be done
- Make propper config file to make the processor universably applicable
- Package dependencies with it or create install script.
