#! /usr/bin/env ruby
# coding: utf-8

# Author: UTUMI Hirosi (utuhiro78 at yahoo dot co dot jp)
# License: Apache License, Version 2.0

`rm -f KEN_ALL.CSV`
`wget -N https://www.post.japanpost.jp/zipcode/dl/kogaki/zip/ken_all.zip`
`unzip ken_all.zip`

filename = "KEN_ALL.CSV"
dicname = filename + ".fixed"

dicfile = File.new(filename, "r")
	lines = dicfile.read.encode("UTF-8", "SJIS")
	lines = lines.split("\n")
dicfile.close

dicfile = File.new(dicname, "w")

lines.length.times do |i|
	# 01101,"064  ","0640820","ホッカイドウ","サッポロシチュウオウク","オオドオリニシ(20-28チョウメ)","北海道","札幌市中央区","大通西（２０〜２８丁目）",1,0,1,0,0,0

	# 0. 全国地方公共団体コード（JIS X0401、X0402）………　半角数字
	# 1. （旧）郵便番号（5桁）………………………………………　半角数字
	# 2. 郵便番号（7桁）………………………………………　半角数字
	# 3. 都道府県名　…………　半角カタカナ（コード順に掲載）　（注1）
	# 4. 市区町村名　…………　半角カタカナ（コード順に掲載）　（注1）
	# 5. 町域名　………………　半角カタカナ（五十音順に掲載）　（注1）
	# 6. 都道府県名　…………　漢字（コード順に掲載）　（注1,2）
	# 7. 市区町村名　…………　漢字（コード順に掲載）　（注1,2）
	# 8. 町域名　………………　漢字（五十音順に掲載）　（注1,2）

	s = lines[i].split(",")

	# 町域の英数字を半角に変換
	# "大通西（２０〜２８丁目）"
	s[8] = s[8].tr('０-９ａ-ｚＡ-Ｚ（）　−','0-9a-zA-Z() \-')

	# 町域に次の文字列が含まれていればスキップ
	ng = ["○", "〔", "〜", "、", "「", "を除く", "以外", "その他", "地割", "不明", "以下に掲載がない場合"]

	# 町域の () 内に除外文字列があるか確認
	if s[8].index("(") != nil
		t = s[8].split("(")[1..-1].join("(")

		ng.length.times do |c|
			if t.index(ng[c]) != nil
				# マッチする場合は町域の読みと表記の「(」以降を削除
				s[5] = s[5].split("(")[0]
				s[8] = s[8].split("(")[0]
				break
			end
		end
	end

	# 町域の () 外に除外文字列があるか確認
	ng.length.times do |c|
		if s[8].index(ng[c]) != nil
			# マッチする場合は町域の読みと表記を空にする
			s[5] = ""
			s[8] = ""
			break
		end
	end

	# 町域の読みの () を取る
	# 「"ハラ(ゴクラクザカ)","原(極楽坂)"」を「"ハラゴクラクザカ","原(極楽坂)"」にする。
	# 表記の () は取らない。「原極楽坂」だと読みにくいので。
	s[5] = s[5].gsub("(", "")
	s[5] = s[5].gsub(")", "")

	dicfile.puts s.join(",")
end

dicfile.close

`rm -f KEN_ALL.CSV`
