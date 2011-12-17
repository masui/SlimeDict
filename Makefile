all:
	ruby -I~/SlimeDict ~/SlimeDict/dicmerge meishi-wikipedia.dic 100 'kdict::リスト' 'kdict::名詞' 'kdict::固有名詞' 'kdict::増井リスト' > /tmp/tmp
	grep -v '.*-' /tmp/tmp > /tmp/tmp1
	ruby -I~/SlimeDict ~/SlimeDict/connection2txt /tmp/tmp1 > dict.txt
