#!/bin/bash
# A Bash script to parse, process, clean the Freebase data dumps.

## Z commands

# Scan through the compressed data
# zmore freebase-rdf-latest.gz

# Grep for specific terms, limit set at 5
# zgrep 'term' -m 5 freebase-rdf-latest.gz

# Pipe the data to another file
# zgrep 'term' freebase-rdf-latest.gz > freebase-triples.txt


## s0-c0 Setting File Names
INPUT_FILE=$1

OUTPUT_FILE_NAME_EN=${INPUT_FILE:0:${#INPUT_FILE}-11}"-name-en-s02-c01.nt"
OUTPUT_FILE_NAME_ALL=${INPUT_FILE:0:${#INPUT_FILE}-11}"-name-all-s02-c01.nt"
OUTPUT_FILE_DESC_EN=${INPUT_FILE:0:${#INPUT_FILE}-11}"-desc-en-s02-c01.nt"
OUTPUT_FILE_DESC_ALL=${INPUT_FILE:0:${#INPUT_FILE}-11}"-desc-all-s02-c01.nt"
OUTPUT_FILE_TYPE=${INPUT_FILE:0:${#INPUT_FILE}-11}"-type-s02-c01.nt"
OUTPUT_FILE_=${INPUT_FILE:0:${#INPUT_FILE}-11}"--s02-c01.nt"
OUTPUT_FILE_=${INPUT_FILE:0:${#INPUT_FILE}-11}"--s02-c01.nt"



## s1-c1 Substring replacement: URLs
# Run on the command line: $ bash parse-triples.sh freebase-rdf-latest

#FB_URI='http:\/\/rdf.freebase.com'
#FB_NS_URI='http:\/\/rdf.freebase.com\/ns'
#W3_URI='http:\/\/www.w3.org\/[0-9]*\/[0-9]*\/[0-9]*-*'

# single sed substitute operation
#sed "s/$FB_NS_URI//g;s/$W3_URI//g;s/$FB_URI//g" $1 | pv -pterb >"$1-c1.nt"


## s1-c2 Substring replacement: <,> Signs
# Run on the command line: $ bash parse-triples.sh freebase-rdf-latest

# single sed substitute operation
#sed "s/<//g;s/>//g" $INPUT_FILE | pv -pterb >$OUTPUT_FILE


## s2-c1 Extract Triples: Name, Description, 
# Specifying triples with specific predicates

# Triples with "name" predicate
grep '/type.object.name' $INPUT_FILE | pv -pterb >$OUTPUT_FILE_NAME_ALL

# Restricting to certain i18n languages
grep '/type.object.name.*@en' $INPUT_FILE | pv -pterb >$OUTPUT_FILE_NAME_EN

# Triples with "description" predicate
grep '/common.topic.description' $INPUT_FILE | pv -pterb >$OUTPUT_FILE_DESC_ALL

# Restricting to certain i18n languages
grep '/common.topic.description.*@en' $INPUT_FILE | pv -pterb >$OUTPUT_FILE_DESC_EN

# Triples with the "type" predicate
grep '/type.object.type' $INPUT_FILE | pv -pterb >$OUTPUT_FILE_TYPE







