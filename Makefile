slime:
	-mkdir tmp
	ruby -Iprograms programs/dicmerge \
		data/wikipedia.txt 500 \
		data/ktai.txt 300 \
		'SlimeDict::リスト' \
		'SlimeDict::名詞' \
		'SlimeDict::固有名詞' \
		'SlimeDict::増井リスト' \
		> tmp/tmp
	grep -v '.*-' tmp/tmp > tmp/tmp1
	ruby -Iprograms programs/connection2txt tmp/tmp1 > dict.txt

gyaim:
	ruby -Iprograms programs/dicmerge \
		data/wikipedia.txt 500 \
		data/ktai.txt 300 \
		'SlimeDict::リスト' \
		'SlimeDict::名詞' \
		'SlimeDict::固有名詞' \
		'SlimeDict::増井リスト' \
		> tmp/tmp
	grep -v '.*-' tmp/tmp > tmp/tmp1
	ruby -Iprograms programs/connection2txt -r rklist.gyaim -n tmp/tmp1 > ~/Gyaim/Resources/dict.txt

all2:
	ruby -Iprograms programs/dicmerge \
		meishi-wikipedia.dic 100 \
		'SlimeDict::リスト' \
		'SlimeDict::名詞' \
		'SlimeDict::固有名詞' \
		'SlimeDict::増井リスト' \
		> tmp/tmp
	grep -v '.*-' tmp/tmp > tmp/tmp1
	ruby -Iprograms programs/connection2txt tmp/tmp1 > dict.txt

backup:
	ruby ~/GyazzBackup/gyazz_backup SlimeDict

wikipedia: corpus/jawiki-latest-pages-articles.xml.bz2
	bzip2 -d < corpus/jawiki-latest-pages-articles.xml.bz2 \
		| head -1000000 \
		| mecab \
		| ruby -Iprograms programs/mecab2dic \
		| sort | uniq -c | sort -r -n \
		| awk '{print $$2 " " $$3 " " $$4 " " $$5}' \
		| head -10000 > data/wikipedia.txt

ktai: corpus/ktai.txt
	cat corpus/ktai.txt \
		| head -1000000 \
		| mecab \
		| ruby -Iprograms programs/mecab2dic \
		| sort | uniq -c | sort -r -n \
		| awk '{print $$2 " " $$3 " " $$4 " " $$5}' \
		| head -10000 > data/ktai.txt

test:
	cat corpus/ktai.txt \
		| head -1000000 \
		| mecab \
		| ruby -Iprograms programs/mecab2dic

catdiff:
	ruby -Iprograms programs/dicmerge 'SlimeDict::カテゴリ' > tmp/tmp
	ruby programs/dicdiff data/wikipedia.txt tmp/tmp | wc

catmore:
	ruby programs/dicdiff data/wikipedia.txt tmp/tmp | more

push:
	git push pitecan.com:/home/masui/git/SlimeDict.git
	git push git@github.com:masui/SlimeDict.git
