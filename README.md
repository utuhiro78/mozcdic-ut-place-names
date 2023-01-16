---
title: Mozc UT Place Name Dictionary
date: 2023-01-15
---

## Overview

Mozc UT Place Name Dictionary is a dictionary converted from the [Japan Post's ZIP code data](https://www.post.japanpost.jp/zipcode/download.html) for Mozc.

Thanks to the Japan Post's ZIP code data team.

## License

mozcdic-ut-place-names.txt: [Public Domain](https://www.post.japanpost.jp/zipcode/dl/readme.html)

> 郵便番号データに限っては日本郵便株式会社は著作権を主張しません。

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
