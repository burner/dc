DC=dmd
CFLAGS=-c -w -Isrc -debug -gc -debug=1024
TARGET=dc
OBJDIR="objs"

all:${TARGET}

OBJS=algo.o dlst.o lexer.o parser.o stringbuffer.o token.o stacktrace.o source.o token.o

$(TARGET): $(OBJS) Makefile src/main.d
	sh IncreBuildId.sh
	$(DC) $(CFLAGS) compilerinfo.d
	$(DC) $(CFLAGS) src/main.d
	$(DC) *.o -ofdc

run: $(TARGET)
	./dc

count:
	wc -l `find src -name "*.d"`

clean:
	rm -f objs/*.o $(TARGET)
	rm -f *.o $(TARGET)

algo.o: Makefile src/util/algo.d 
	$(DC) $(CFLAGS) src/util/algo.d 

dlst.o: Makefile src/container/dlst.d 
	$(DC) $(CFLAGS) src/container/dlst.d 

lexer.o: Makefile src/lex/lexer.d
	$(DC) $(CFLAGS) src/lex/lexer.d 

parser.o: Makefile src/pars/parser.d
	$(DC) $(CFLAGS) src/pars/parser.d 

source.o: Makefile src/lex/source.d
	$(DC) $(CFLAGS) src/lex/source.d 

stacktrace.o: Makefile src/util/stacktrace.d
	$(DC) $(CFLAGS) src/util/stacktrace.d 

stringbuffer.o: Makefile src/util/stringbuffer.d
	$(DC) $(CFLAGS) src/util/stringbuffer.d 

token.o: Makefile src/lex/token.d
	$(DC) $(CFLAGS) src/lex/token.d 
