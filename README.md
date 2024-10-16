## Overview

A dictionary converted from the [Japan Post's ZIP code data](https://www.post.japanpost.jp/zipcode/download.html) for Mozc.

Thanks to the Japan Post's ZIP code data team.

## License

mozcdic-ut-place-names.txt: [Public Domain](https://www.post.japanpost.jp/zipcode/dl/readme.html)

> 郵便番号データに限っては日本郵便株式会社は著作権を主張しません。

Source code: Apache License, Version 2.0

## Usage

Add the dictionary to dictionary00.txt and build Mozc as usual.

```
tar xf mozcdic-ut-*.txt.tar.bz2
cat mozcdic-ut-*.txt >> ../mozc-master/src/data/dictionary_oss/dictionary00.txt
```

To modify the costs for words or merge multiple UT dictionaries into one, use this tool:

[merge-ut-dictionaries](https://github.com/utuhiro78/merge-ut-dictionaries)

## Update this dictionary with the latest stuff

Requirement(s): python-jaconv

```
cd src/
sh make.sh
```

[HOME](http://linuxplayers.g1.xrea.com/mozc-ut.html)
