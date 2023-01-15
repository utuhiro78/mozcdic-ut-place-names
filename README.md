---
title: Mozc UT Place Name Dictionary
date: 2023-01-15
---

## Overview

Mozc UT Place Name Dictionary is a Japanese place name dictionary converted from [Japan Post's ZIP code data](https://www.post.japanpost.jp/zipcode/download.html) for Mozc.

Thanks to the Japan Post's ZIP code data team.

## License

mozcdic-ut-place-names.txt: [Public Domain](https://www.post.japanpost.jp/zipcode/dl/readme.html)

Source code: Apache License, Version 2.0

## Usage

Add mozcdic-ut-*.txt to dictionary00.txt and build Mozc as usual.

```
tar xf mozcdic-ut-*.txt.tar.bz2
cat ../mozc-master/src/data/dictionary_oss/dictionary00.txt mozcdic-ut-*.txt > dictionary00.txt.new
mv dictionary00.txt.new ../mozc-master/src/data/dictionary_oss/dictionary00.txt
```

Except for mozcdic-ut-jawiki, the costs are not modified by jawiki-latest-all-titles.

To modify the costs or merge multiple UT dictionaries into one, use the following tool:

[merge-ut-dictionaries](https://github.com/utuhiro78/merge-ut-dictionaries)

## If you create your own UT dictionary

Requirement(s): ruby, rsync

```
cd src/
sh make.sh
```

[HOME](http://linuxplayers.g1.xrea.com/mozc-ut.html)
