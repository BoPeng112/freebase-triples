#!/bin/bash
# A Bash script to parse, process, clean the Freebase data dumps.

########## ########## ########## ########## ##########
## Z Commands Overview
########## ########## ########## ########## ##########

# Scan through the compressed data
# zmore freebase-rdf-latest.gz

# Grep for specific terms, limit set at 5
# zgrep 'term' -m 5 freebase-rdf-latest.gz

# Pipe the data to another file
# zgrep 'term' freebase-rdf-latest.gz > freebase-triples.txt


########## ########## ########## ########## ##########
## Stages and Changes
########## ########## ########## ########## ##########

## s3-c0 Setting File Names
INPUT_FILE=$1

OUTPUT_FILE_=${INPUT_FILE:0:${#INPUT_FILE}-11}"--s02-c01.nt"  # template
OUTPUT_FILE_=${INPUT_FILE:0:${#INPUT_FILE}-11}"--s02-c01.nt"  # template


## s3-c0 Browse Data

# Scroll up and down!
less fb-rdf-pred-bicycles



## s3-c1 Query Triples:

# Specific topic mid
cat freebase-rdf-latest-type-s02-c01 | parallel --pipe --block 2M --progress 
grep -E "\</m.02mjmr\>" >test.txt



## s3-c2 Analytics

# All Slices
# Returns a long list of number of triples
wc -l fb-rdf-pred-*

# Slice Level Analytics
# Example slice: fb-rdf-pred-bicycles

# Number of  triples
wc -l fb-rdf-pred-bicycles
# -> 313

# Unique SPO counts
# Sub
cat fb-rdf-pred-bicycles | parallel --pipe --block 2M --progress awk -F"\t" \''!seen[$1]++ { print $1 }'\' | wc -l
# -> 166

# Pred
cat fb-rdf-pred-bicycles | parallel --pipe --block 2M --progress awk -F"\t" \''!seen[$2]++ { print $2 }'\' | wc -l
# -> 5  # this should be quite low as it ~= the domain properties

cat fb-rdf-pred-bicycles | parallel --pipe --block 2M --progress awk -F"\t" \''!seen[$2]++ { print $2 }'\'
# ->
# </bicycles.bicycle_model.manufacturer>
# </bicycles.bicycle_model.speeds>
# </bicycles.bicycle_model.bicycle_type>
# </bicycles.bicycle_manufacturer.bicycle_models>
# </bicycles.bicycle_type.bicycle_models_of_this_type>

# Obj
cat fb-rdf-pred-bicycles | parallel --pipe --block 2M --progress awk -F"\t" \''!seen[$3]++ { print $3 }'\' | wc -l
# -> 170



## s3-c3 Search Identifier Triples

# Identify Schema

# Name: Types, Properties
cat fb-rdf-name-en-s02-c01 | parallel --pipe --block 2M --progress awk -F"\t" \''$1 ~ "</bicycles.*"'\'
# ->
# </bicycles.bicycle_model.bicycle_type>  </type.object.name> "Bicycle type"@en   .
# </bicycles.bicycle_model.speeds>    </type.object.name> "Speeds"@en .
# </bicycles.bicycle_type>    </type.object.name> "Bicycle type"@en   .
# </bicycles.bicycle_manufacturer.bicycle_models> </type.object.name> "Bicycle models"@en .
# </bicycles.bicycle_manufacturer>    </type.object.name> "Bicycle manufacturer"@en   .
# </bicycles.bicycle_type.bicycle_models_of_this_type>    </type.object.name> "Bicycle models of this type"@en    .
# </bicycles.bicycle_model.manufacturer>  </type.object.name> "Manufacturer"@en   .
# </bicycles.bicycle_model>   </type.object.name> "Bicycle model"@en  .


# Desc: Types
# Below doesn't work as schema types are stored by mid. Find mid via web archives.
cat fb-rdf-desc-en-s02-c01 | parallel --pipe --block 2M --progress awk -F"\t" \''$1 ~ "</bicycles.*"'\'

cat fb-rdf-desc-s02-c01-v3 | parallel --pipe --block 2M --progress awk -F"\t" \''$1 == "</m.05kdnd7>"'\'
# -> # Bicycle type
# </m.05kdnd7>   </common.topic.description> "Broad types or categories of bicycles, such as mountain bike, hybrid, recumbent, folding, etc."@en .

cat fb-rdf-desc-s02-c01-v3 | parallel --pipe --block 2M --progress awk -F"\t" \''$1 == "</m.05kdndh>"'\'
# -> # Bicycle model
# </m.05kdndh>   </common.topic.description> "This is a fairly high level type for models of bike.  It usually represents the model name as described on manufacturer or reseller websites.  Although there may be sub-models within these (eg. different components, mens/women's models, colours, slight changes from year to year), we are not yet modelling at that level.  Please let us know if you need lower-level detail."@en   .

cat fb-rdf-desc-s02-c01-v3 | parallel --pipe --block 2M --progress awk -F"\t" \''$1 == "</m.05kdndr>"'\'
# -> Bicycle manufacturer
# </m.05kdndr>  </common.topic.description> "The company that builds the bike (Fat city, Cannondale, Trek, etc.)."@en   . 


# Desc: Properties
# </bicycles.bicycle_model.bicycle_type>                = /m.05kdnfz
# </bicycles.bicycle_model.speeds>                      = /m.05kdqn3
# </bicycles.bicycle_model.manufacturer>                = /m.0g9pvjw
# </bicycles.bicycle_manufacturer.bicycle_models>       = /m.05kdn9s
# </bicycles.bicycle_type.bicycle_models_of_this_type>  = /m.05kdnj7
# ->
# </m.05kdnfz>  </common.topic.description> "The type or category of bike, eg. mountain bike, recumbent, hybrid"@en .












