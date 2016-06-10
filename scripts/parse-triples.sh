#!/bin/bash
# A Bash script to parse, process, clean the Freebase data dumps.

## Z commands

# Scan through the compressed data
# zmore freebase-rdf-latest.gz

# Grep for specific terms, limit set at 5
# zgrep 'term' -m 5 freebase-rdf-latest.gz

# Pipe the data to another file
# zgrep 'term' freebase-rdf-latest.gz > freebase-triples.txt


## Substring replacement 
# Run on the command line: $ bash parse-triples.sh

FB_URI='http:\/\/rdf.freebase.com\/ns'
W3_URI='http:\/\/www.w3.org\/[0-9]*\/[0-9]*\/[0-9]*-*'

# TODO: make into a single operation
sed "s/$FB_URI//g" <../data/fb-triples-10k.txt >../data/fb-triples-10k-c1.txt
sed "s/$W3_URI//g" <../data/fb-triples-10k-c1.txt >../data/fb-triples-10k-c2.txt





