c_minus: lex.yy.o c_minus.tab.o
	gcc -o c_minus $^

c_minus.tab.h: c_minus.y
	bison --debug --verbose -d c_minus.y

c_minus.tab.c: c_minus.y
	bison -d c_minus.y

lex.yy.c: c_minus.l c_minus.tab.h
	flex  c_minus.l