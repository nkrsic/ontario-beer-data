# Repository: ontario-beer-data
Clean version of Government of Ontario manufacturers, microbrewers, and beer brands dataset.

The original CSV download lacked quote characters around most text strings, 
making it difficult to use in R or other open source tools. There were also 
data entry errors in the column specifying the manufacturer type. These were 
obvious and easy-to-clean mis-spellings of existing factor levels. 

# The raw data
| Source        | Date downloaded|Download Format|Char. Encoding|Date last modified|
| ------------- |:-------------:|:----------:|:------------:|:--------------:|
| https://www.ontario.ca/data/beer-manufacturers-microbrewers-and-brands | Oct. 4, 2017 | CSV |ISO-8859-1|Sept. 26, 2017|

# Cleaning process

1) The original CSV file from the Ontario government website was opened with 
Microsoft Excel 2013, and a VBA macro was used to export a CSV version with 
quote characters (provided by Microsoft -- see below). 
    * This step resulted in an intermediate file, 'beer_w_quotes.csv'. This file
      preserves the original ISO 8859-1 encoding. 
      
2) An R script, 'beer-explore.R', was used to clean data entry errors 
still remaining in 'beer_w_quotes.csv, and to clearly mark empty strings as "#NA#". The cleaned datasets were written to separate files for UTF-8 and ISO 8859-1 encodings respectively. 

# Cleaned data

The R cleaning script will create the following cleaned CSV files:

* 'beer_clean_iso8859_1.csv'
    * Characters encoded in ISO 8859-1 or 'latin1' encoding.
* 'beer_clean_utf8.csv'
    * Characters encoded in UTF-8 encoding.  
    
For both of the above files, the string "#NA#" is used to denote an empty
string. These empty strings were present in the original dataset either because
the manufacturer did not have a brand associated with it, or because of possibly
data entry errors which left said fields blank. 

# Usage notes

The cleaned CSV files should work well with most software at this point, 
provided the user keeps track of which character encoding the dataset is using.
To this end, the encoding has been written into the cleaned filenames. 

Open-source tools like R and Libre Office Calc (open-source alternative to
Excel) should read and display accented letters correctly, provided the user
selects the correct encoding type when importing the data. 

### R Users

* R users should set the 'encoding' parameter of the relevant read function to
  appropriate value. 
    * If using 'beer_clean_iso8859_1.csv', set encoding to 'latin1'
    * If using 'beer_clean_utf8.csv', set encoding to 'UTF-8'

```
df <- read.table("./beer_clean_iso8859_1.csv", 
                 sep=",", 
                 header=TRUE,
                 encoding="latin1", # File is encoded ISO 8859-1
                 colClasses=c("character","character","character")
                 ) 
```

# Links

#### VBA Macro for Exporting CSV with Quotes

* [Microsoft Support Page - Excel VBA Macro](https://support.microsoft.com/en-ca/help/291296/procedure-to-export-a-text-file-with-both-comma-and-quote-delimiters-i)


