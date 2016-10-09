#!/bin/bash
# A Bash script to parse, process, clean the Freebase data dumps.

## s0-c0 Setting File Names
INPUT_FILE=$1
OUTPUT_FILE=${INPUT_FILE:0:${#INPUT_FILE}-11}"-s01-c03.nt"


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

## s1-c3 Substring replacement: Schema IDs /.. to ///
sed "s/\./\//g" $INPUT_FILE | pv -pterb >$OUTPUT_FILE # TODO: better regex needed



