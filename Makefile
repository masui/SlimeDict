all:
	ruby -I~/SlimeDict/programs ~/SlimeDict/programs/dicmerge \
		meishi-wikipedia.dic 100 \
		'SlimeDict::リスト' \
		'SlimeDict::名詞' \
		'SlimeDict::固有名詞' \
		'SlimeDict::増井リスト' \
		> /tmp/tmp
	grep -v '.*-' /tmp/tmp > /tmp/tmp1
	ruby -I~/SlimeDict/programs ~/SlimeDict/programs/connection2txt /tmp/tmp1 > dict.txt

backup:
	ruby ~/GyazzBackup/gyazz_backup SlimeDict

wikipedia: corpus/jawiki-latest-pages-articles.xml.bz2
	bzip2 -d < corpus/jawiki-latest-pages-articles.xml.bz2 \
		| head -1000000 \
		| mecab \
		| ruby -Iprograms programs/mecab2dic \
		| sort | uniq -c | sort -r -n \
		| awk '{print $$2 " " $$3 " " $$4 " " $$5}' \
		| head -6000 > wikipedia.txt

ktai: corpus/ktai.txt
	cat corpus/ktai.txt \
		| head -1000000 \
		| mecab \
		| ruby -Iprograms programs/mecab2dic \
		| sort | uniq -c | sort -r -n \
		| awk '{print $$2 " " $$3 " " $$4 " " $$5}' \
		| head -6000 > ktai.txt

meishi-wikipedia.txt: corpus/jawiki-latest-pages-articles.xml.bz2
	bzip2 -d < corpus/jawiki-latest-pages-articles.xml.bz2 \
		| head -100000 \
		| mecab \
		| ruby -Iprograms programs/mecab-meishi.rb \
		| sort | uniq -c | sort -r -n \
		| ruby -Iprograms programs/freq2dic '[名詞]' '[名詞接続]' \
		| head -6000 > meishi-wikipedia.txt

meishi-ktai.txt: corpus/ktai.txt
	cat corpus/ktai.txt \
		| head -1000000 \
		| mecab \
		| ruby -Iprograms programs/mecab-meishi.rb \
		| sort | uniq -c | sort -r -n \
		| ruby -Iprograms programs/freq2dic '[名詞]' '[名詞接続]' \
		| head -6000 > meishi-ktai.txt

catdiff:
	ruby -I~/SlimeDict/programs programs/dicmerge 'SlimeDict::カテゴリ' > /tmp/tmp
	ruby programs/dicdiff meishi-wikipedia.dic /tmp/tmp | wc

catmore:
	ruby programs/dicdiff meishi-wikipedia.dic /tmp/tmp | more

push:
	git push pitecan.com:/home/masui/git/SlimeDict.git
	git push git@github.com:masui/SlimeDict.git
