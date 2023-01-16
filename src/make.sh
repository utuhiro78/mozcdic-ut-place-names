#!/bin/bash

# Author: UTUMI Hirosi (utuhiro78 at yahoo dot co dot jp)
# License: Apache License, Version 2.0

ruby fix_ken_all.rb
ruby generate_place_names_for_mozc.rb

tar cjf mozcdic-ut-place-names.txt.tar.bz2 mozcdic-ut-place-names.txt
mv mozcdic-ut-place-names.txt* ../

rm -rf mozcdic-ut-place-names-release/
rsync -a ../* mozcdic-ut-place-names-release --exclude=jawiki-* --exclude=mecab-* --exclude=mozcdic-ut-*.txt --exclude=ken_all* --exclude=KEN_ALL*
