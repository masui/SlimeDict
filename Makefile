all:
	ruby -I~/SlimeDict ~/SlimeDict/dicmerge meishi-wikipedia.dic 100 'SlimeDict::リスト' 'SlimeDict::名詞' 'SlimeDict::固有名詞' 'SlimeDict::増井リスト' > /tmp/tmp
	grep -v '.*-' /tmp/tmp > /tmp/tmp1
	ruby -I~/SlimeDict ~/SlimeDict/connection2txt /tmp/tmp1 > dict.txt

get:
	ruby ~/GyazzBackup/gyazz_backup SlimeDict

old:
	ruby -I~/SlimeDict ~/SlimeDict/dicmerge meishi-wikipedia.dic 100 'kdict::リスト' 'kdict::名詞' 'kdict::固有名詞' 'kdict::増井リスト' > /tmp/tmp
	grep -v '.*-' /tmp/tmp > /tmp/tmp1
	ruby -I~/SlimeDict ~/SlimeDict/connection2txt.save /tmp/tmp1 > dict.txt

catdiff:
	ruby -I~/SlimeDict ~/SlimeDict/dicmerge 'SlimeDict::カテゴリ' > /tmp/tmp
	ruby dicdiff meishi-wikipedia.dic /tmp/tmp | wc

catmore:
	ruby dicdiff meishi-wikipedia.dic /tmp/tmp | more

push:
	git push pitecan.com:/home/masui/git/SlimeDict.git
	git push git@github.com:masui/Slime.git

