#! /usr/bin/env ruby
# coding: utf-8

# Author: UTUMI Hirosi (utuhiro78 at yahoo dot co dot jp)
# License: APACHE LICENSE, VERSION 2.0

require 'nkf'

filename = "KEN_ALL.CSV.fixed"
dicname = "mozcdic-ut-place-names.txt"
id_mozc = "1847"

dicfile = File.new(filename, "r")
	lines = dicfile.read.split("\n")
dicfile.close

# 数字の1から9までの読みを作成
d1 = ["", "いち", "に", "さん", "よん", "ご", "ろく", "なな", "はち", "きゅう"]

# 数字の10から59までの読みを作成
# さっぽろしひがしくきた51じょうひがし
d2 = ["じゅう", "にじゅう", "さんじゅう", "よんじゅう", "ごじゅう"]

5.times do |p|
	10.times do |q|
		d1[((p + 1) * 10) + q] = d2[p] + d1[q]
	end
end

l2 = []
p = 0

lines.length.times do |i|
	# エントリの例
	# 01101,"064  ","0640820","ホッカイドウ","サッポロシチュウオウク","オオドオリニシ(20-28チョウメ)","北海道","札幌市中央区","大通西（２０〜２８丁目）",1,0,1,0,0,0

	s = lines[i].gsub("\"", "")
	s = s.split(",")

	# 読みをひらがなに変換
	# 「tr('ァ-ヴ', 'ぁ-ゔ')」よりnkfのほうが速い
	s[3] = NKF.nkf("--hiragana -w -W", s[3])
	s[4] = NKF.nkf("--hiragana -w -W", s[4])
	s[5] = NKF.nkf("--hiragana -w -W", s[5])

	# 読みの「・」を取る
	s[5] = s[5].gsub("・", "")

	# 市を出力
	t = [s[4], id_mozc, id_mozc, "9000", s[7]]
	l2[p] = t.join("	")
	p = p + 1

	# 町の読みが半角数字を含むか確認
	c = s[5].scan(/\d/).join.to_i

	# 町の読みの半角数字が59以下の場合はひらがなに変換
	# さっぽろしひがしくきた51じょうひがし
	if c > 0 && c < 60
		s[5] = s[5].gsub(c.to_s, d1[c])
	end

	# 町の読みがひらがな以外を含む場合はスキップ
	# 「自由が丘(3～7丁目)」「OAPたわー」
	if s[5] != s[5].scan(/[ぁ-ゔー]/).join ||
	# 町の表記が空の場合はスキップ
	s[8] == ""
		next
	end

	# 町を出力
	t = [s[5], id_mozc, id_mozc, "9000", s[8]]
	l2[p] = t.join("	")
	p = p + 1

	# 市+町を出力
	t = [s[4..5].join, id_mozc, id_mozc, "9000", s[7..8].join]
	l2[p] = t.join("	")
	p = p + 1
end

lines = l2
l2 = []

# 重複行を削除
lines = lines.uniq.sort

dicfile = File.new(dicname, "w")
	dicfile.puts lines
dicfile.close
